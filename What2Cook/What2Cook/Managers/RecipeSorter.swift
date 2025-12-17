//
//  RecipeSorter.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//


import Foundation

struct RecipeScore {
    let recipe: Recipe
    let matchResult: RecipeMatchResult
    let totalScore: Double
    
    // Individual score components
    let ingredientScore: Double
    let expiryScore: Double
    let preferenceScore: Double
    let timeOfDayScore: Double
}

class RecipeSorter {
    static let shared = RecipeSorter()
    
    private let recipeMatcher = RecipeMatcher.shared
    private let preferencesManager = UserPreferencesManager.shared
    
    // Score weights (total = 1.0)
    private let ingredientWeight: Double = 0.40      // 40% - most important
    private let expiryWeight: Double = 0.25          // 25% - use expiring items
    private let preferenceWeight: Double = 0.25      // 25% - user preferences
    private let timeOfDayWeight: Double = 0.10       // 10% - time-appropriate meals
    
    private init() {}
    
    // MARK: - Sort Recipes
    
    func sortRecipes(_ recipes: [Recipe]) -> [Recipe] {
        let scores = calculateScores(for: recipes)
        let sorted = scores.sorted { $0.totalScore > $1.totalScore }
        return sorted.map { $0.recipe }
    }
    
    // MARK: - Calculate Scores
    
    func calculateScores(for recipes: [Recipe]) -> [RecipeScore] {
        let matchResults = recipeMatcher.matchRecipes(recipes)
        let preferences = preferencesManager.getPreferences()
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        return matchResults.map { matchResult in
            let ingredientScore = calculateIngredientScore(matchResult)
            let expiryScore = calculateExpiryScore(matchResult)
            let preferenceScore = calculatePreferenceScore(matchResult.recipe, preferences: preferences)
            let timeOfDayScore = calculateTimeOfDayScore(matchResult.recipe, hour: currentHour)
            
            let totalScore = (ingredientScore * ingredientWeight) +
                           (expiryScore * expiryWeight) +
                           (preferenceScore * preferenceWeight) +
                           (timeOfDayScore * timeOfDayWeight)
            
            return RecipeScore(
                recipe: matchResult.recipe,
                matchResult: matchResult,
                totalScore: totalScore,
                ingredientScore: ingredientScore,
                expiryScore: expiryScore,
                preferenceScore: preferenceScore,
                timeOfDayScore: timeOfDayScore
            )
        }
    }
    
    // MARK: - Individual Score Calculations
    
    private func calculateIngredientScore(_ matchResult: RecipeMatchResult) -> Double {
        // Score from 0.0 to 1.0 based on ingredient availability
        return Double(matchResult.availabilityPercentage) / 100.0
    }
    
    private func calculateExpiryScore(_ matchResult: RecipeMatchResult) -> Double {
        // Higher score if recipe uses expiring ingredients
        if matchResult.hasExpiringIngredients {
            // Bonus based on how many expiring ingredients are used
            let expiringCount = matchResult.expiringIngredientNames.count
            let maxBonus = 1.0
            let bonusPerIngredient = 0.3
            return min(maxBonus, Double(expiringCount) * bonusPerIngredient)
        }
        return 0.0
    }
    
    private func calculatePreferenceScore(_ recipe: Recipe, preferences: UserPreferences) -> Double {
        var score = 0.0
        var maxScore = 0.0
        
        // Cuisine match (0.4 of preference score)
        maxScore += 0.4
        if !preferences.selectedCuisines.isEmpty {
            if preferences.selectedCuisines.contains(where: { $0.lowercased() == recipe.cuisine.lowercased() }) {
                score += 0.4
            }
        } else {
            // If no cuisine preference, give neutral score
            score += 0.2
        }
        
        // Dietary restrictions match (0.3 of preference score)
        maxScore += 0.3
        if !preferences.dietaryRestrictions.isEmpty {
            let recipeTags = recipe.tags.map { $0.lowercased() }
            let matchingDietary = preferences.dietaryRestrictions.filter { dietary in
                recipeTags.contains(dietary.lowercased())
            }
            
            if matchingDietary.count > 0 {
                score += 0.3
            } else {
                // Check if recipe violates dietary restrictions
                let violates = preferences.dietaryRestrictions.contains { dietary in
                    let normalized = dietary.lowercased()
                    if normalized == "vegan" && !recipeTags.contains("vegan") {
                        // Check if recipe has animal products
                        return recipe.ingredients.contains { ingredient in
                            let name = ingredient.name.lowercased()
                            return name.contains("meat") || name.contains("chicken") ||
                                   name.contains("beef") || name.contains("fish") ||
                                   name.contains("egg") || name.contains("milk") ||
                                   name.contains("cheese") || name.contains("butter")
                        }
                    }
                    return false
                }
                
                if violates {
                    score += 0.0  // No score if violates
                } else {
                    score += 0.15  // Partial score if doesn't match but doesn't violate
                }
            }
        } else {
            score += 0.15
        }
        
        // Skill level match (0.3 of preference score)
        maxScore += 0.3
        let userSkill = preferences.skillLevel.lowercased()
        let recipeDifficulty = recipe.difficulty.lowercased()
        
        // Map difficulties to levels
        let skillLevels = ["beginner": 1, "easy": 1, "medium": 2, "intermediate": 2, "hard": 3, "advanced": 3]
        let userLevel = skillLevels[userSkill] ?? 2
        let recipeLevel = skillLevels[recipeDifficulty] ?? 2
        
        if recipeLevel <= userLevel {
            score += 0.3  // Recipe is at or below user's skill level
        } else if recipeLevel == userLevel + 1 {
            score += 0.15  // Recipe is slightly challenging (good!)
        } else {
            score += 0.0  // Recipe is too difficult
        }
        
        // Normalize to 0-1 range
        return maxScore > 0 ? score / maxScore : 0.5
    }
    
    private func calculateTimeOfDayScore(_ recipe: Recipe, hour: Int) -> Double {
        // Determine meal type based on time
        let mealType: String
        switch hour {
        case 5..<11:
            mealType = "breakfast"
        case 11..<15:
            mealType = "lunch"
        case 15..<18:
            mealType = "snack"
        case 18..<23:
            mealType = "dinner"
        default:
            return 0.5  // Late night - neutral score
        }
        
        // Check if recipe tags match meal type
        let recipeTags = recipe.tags.map { $0.lowercased() }
        
        if recipeTags.contains(mealType) {
            return 1.0  // Perfect match
        }
        
        // Partial matches
        if mealType == "breakfast" {
            if recipeTags.contains("brunch") || recipe.time <= 20 {
                return 0.7
            }
        } else if mealType == "lunch" {
            if recipeTags.contains("dinner") && recipe.time <= 45 {
                return 0.6  // Lighter dinners work for lunch
            }
        } else if mealType == "dinner" {
            if recipeTags.contains("lunch") {
                return 0.6  // Lunch recipes work for dinner
            }
        }
        
        return 0.3  // Not ideal timing
    }
}
