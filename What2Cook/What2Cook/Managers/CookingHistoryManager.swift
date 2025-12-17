//
//  CookingHistoryManager.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 17.12.2025.
//

import Foundation

struct CookedRecipe: Codable, Identifiable {
    let id: UUID
    let recipeName: String
    let recipeImage: String
    let servings: Int
    let dateCool: Date
    let ingredientsUsed: [String]
    
    init(recipeName: String, recipeImage: String, servings: Int, ingredientsUsed: [String]) {
        self.id = UUID()
        self.recipeName = recipeName
        self.recipeImage = recipeImage
        self.servings = servings
        self.dateCool = Date()
        self.ingredientsUsed = ingredientsUsed
    }
}

class CookingHistoryManager {
    static let shared = CookingHistoryManager()
    
    private let userDefaultsKey = "cookingHistory"
    private var history: [CookedRecipe] = []
    
    private init() {
        loadHistory()
    }
    
    // MARK: - Get History
    
    func getAllHistory() -> [CookedRecipe] {
        return history.sorted { $0.dateCool > $1.dateCool }  // Most recent first
    }
    
    func getRecentHistory(limit: Int = 10) -> [CookedRecipe] {
        return Array(getAllHistory().prefix(limit))
    }
    
    func getHistoryForWeek() -> [CookedRecipe] {
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return history.filter { $0.dateCool >= weekAgo }
    }
    
    // MARK: - Add to History
    
    func addCookedRecipe(_ recipe: Recipe, servings: Int) {
        let ingredientNames = recipe.ingredients.map { $0.name }
        
        let cookedRecipe = CookedRecipe(
            recipeName: recipe.name,
            recipeImage: recipe.imageName,
            servings: servings,
            ingredientsUsed: ingredientNames
        )
        
        history.append(cookedRecipe)
        saveHistory()
        
        subtractIngredientsFromFridge(recipe.ingredients)
    }
    
    // MARK: - Subtract Ingredients from Fridge
    
    private func subtractIngredientsFromFridge(_ ingredients: [Recipe.Ingredient]) {
        let fridgeManager = FridgeManager.shared
        
        for ingredient in ingredients {
            if let fridgeItem = fridgeManager.findMatchingItem(for: ingredient.name) {
                fridgeManager.deleteItem(fridgeItem)
            }
        }
    }
    
    // MARK: - Delete from History
    
    func deleteHistory(_ cookedRecipe: CookedRecipe) {
        history.removeAll { $0.id == cookedRecipe.id }
        saveHistory()
    }
    
    func clearAllHistory() {
        history.removeAll()
        saveHistory()
    }
    
    // MARK: - Statistics
    
    func getTotalRecipesCooked() -> Int {
        return history.count
    }
    
    func getMostCookedRecipes(limit: Int = 5) -> [(name: String, count: Int)] {
        let grouped = Dictionary(grouping: history, by: { $0.recipeName })
        let sorted = grouped.map { (name: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
        return Array(sorted.prefix(limit))
    }
    
    // MARK: - Persistence
    
    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([CookedRecipe].self, from: data) {
            self.history = decoded
        }
    }
}
