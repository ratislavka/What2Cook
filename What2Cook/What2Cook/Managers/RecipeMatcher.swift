//
//  RecipeMatcher.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import Foundation

struct RecipeMatchResult {
    let recipe: Recipe
    let availableCount: Int
    let totalCount: Int
    let missingIngredients: [Recipe.Ingredient]
    let availabilityPercentage: Int
    let hasExpiringIngredients: Bool
    let expiringIngredientNames: [String]
    
    var isFullyAvailable: Bool {
        return availableCount == totalCount
    }
}

class RecipeMatcher {
    static let shared = RecipeMatcher()
    
    private let fridgeManager = FridgeManager.shared
    
    private init() {}
    
    // MARK: - Match Single Recipe
    
    func matchRecipe(_ recipe: Recipe) -> RecipeMatchResult {
        var availableCount = 0
        var missingIngredients: [Recipe.Ingredient] = []
        var expiringIngredientNames: [String] = []
        
        for ingredient in recipe.ingredients {
            if let fridgeItem = fridgeManager.findMatchingItem(for: ingredient.name) {
                availableCount += 1
                
                if fridgeItem.daysUntilExpiry <= 5 {
                    expiringIngredientNames.append(fridgeItem.name)
                }
            } else {
                missingIngredients.append(ingredient)
            }
        }
        
        let totalCount = recipe.ingredients.count
        let percentage = totalCount > 0 ? Int((Double(availableCount) / Double(totalCount)) * 100) : 0
        
        return RecipeMatchResult(
            recipe: recipe,
            availableCount: availableCount,
            totalCount: totalCount,
            missingIngredients: missingIngredients,
            availabilityPercentage: percentage,
            hasExpiringIngredients: !expiringIngredientNames.isEmpty,
            expiringIngredientNames: expiringIngredientNames
        )
    }
    
    // MARK: - Match Multiple Recipes
    
    func matchRecipes(_ recipes: [Recipe]) -> [RecipeMatchResult] {
        return recipes.map { matchRecipe($0) }
    }
    
    // MARK: - Update Recipe Ingredients Availability
    
    func updateRecipeIngredientsAvailability(_ recipe: Recipe) -> Recipe {
        let updatedIngredients = recipe.ingredients.map { ingredient -> Recipe.Ingredient in
            let isAvailable = fridgeManager.findMatchingItem(for: ingredient.name) != nil
            return Recipe.Ingredient(
                name: ingredient.name,
                amount: ingredient.amount,
                isAvailable: isAvailable
            )
        }
        
        // Create new recipe with updated ingredients
        // Using  Recipe's actual initializer
        let availableCount = updatedIngredients.filter { $0.isAvailable }.count
        
        return Recipe(
            name: recipe.name,
            time: recipe.time,
            difficulty: recipe.difficulty,
            cuisine: recipe.cuisine,
            ingredientsAvailable: availableCount,
            imageName: recipe.imageName,
            servings: recipe.servings,
            ingredients: updatedIngredients,
            steps: recipe.steps,
            tags: recipe.tags
        )
    }
    
    // MARK: - Get Recipes That Can Be Made
    
    func getFullyAvailableRecipes(from recipes: [Recipe]) -> [Recipe] {
        return matchRecipes(recipes)
            .filter { $0.isFullyAvailable }
            .map { $0.recipe }
    }
    
    // MARK: - Get Recipes with Expiring Ingredients
    
    func getRecipesWithExpiringIngredients(from recipes: [Recipe]) -> [RecipeMatchResult] {
        return matchRecipes(recipes)
            .filter { $0.hasExpiringIngredients }
    }
}
