//
//  RecipeService.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    
    private let sorter = RecipeSorter.shared
    private let filter = RecipeFilterManager.shared
    private let matcher = RecipeMatcher.shared
    
    private init() {}
    
    // MARK: - Get Sorted and Filtered Recipes
    
    /// Main method: Get recipes sorted by priority with optional filters
    func getRecommendedRecipes(
        from allRecipes: [Recipe],
        applyingFilters filterStrings: [String] = []
    ) -> [Recipe] {
        // First apply filters
        var recipes = allRecipes
        if !filterStrings.isEmpty {
            recipes = filter.applyFilterStrings(filterStrings, to: recipes)
        }
        
        // Then sort by priority
        return sorter.sortRecipes(recipes)
    }
    
    // MARK: - Get Recipe with Updated Ingredient Availability
    
    /// Returns recipe with ingredient availability updated based on fridge
    func getRecipeWithAvailability(_ recipe: Recipe) -> Recipe {
        return matcher.updateRecipeIngredientsAvailability(recipe)
    }
    
    /// Returns multiple recipes with updated availability
    func getRecipesWithAvailability(_ recipes: [Recipe]) -> [Recipe] {
        return recipes.map { matcher.updateRecipeIngredientsAvailability($0) }
    }
    
    // MARK: - Get Recipe Match Information
    
    /// Get detailed match info for a recipe (available count, percentage, etc.)
    func getMatchResult(for recipe: Recipe) -> RecipeMatchResult {
        return matcher.matchRecipe(recipe)
    }
    
    /// Get match results for multiple recipes
    func getMatchResults(for recipes: [Recipe]) -> [RecipeMatchResult] {
        return matcher.matchRecipes(recipes)
    }
    
    // MARK: - Get Specific Recipe Lists
    
    /// Get recipes that can be made completely with available ingredients
    func getFullyAvailableRecipes(from allRecipes: [Recipe]) -> [Recipe] {
        return matcher.getFullyAvailableRecipes(from: allRecipes)
    }
    
    /// Get recipes that use expiring ingredients
    func getRecipesUsingExpiringIngredients(from allRecipes: [Recipe]) -> [RecipeMatchResult] {
        return matcher.getRecipesWithExpiringIngredients(from: allRecipes)
    }
    
    // MARK: - Apply Only Filters (no sorting)
    
    /// Apply filters without sorting
    func applyFilters(_ filterStrings: [String], to recipes: [Recipe]) -> [Recipe] {
        return filter.applyFilterStrings(filterStrings, to: recipes)
    }
    
    // MARK: - Get Detailed Scores (for debugging/analytics)
    
    /// Get detailed scoring information for recipes
    func getRecipeScores(for recipes: [Recipe]) -> [RecipeScore] {
        return sorter.calculateScores(for: recipes)
    }
}
