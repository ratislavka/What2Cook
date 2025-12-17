//
//  RecipeFilterManager.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//


import Foundation

enum RecipeFilter {
    case quickMeals(maxMinutes: Int)  // e.g., "< 30 min"
    case difficulty(String)            // e.g., "Easy"
    case dietary(String)               // e.g., "Vegan", "Vegetarian"
    case cuisine(String)               // e.g., "Italian", "Mexican"
    
    var displayName: String {
        switch self {
        case .quickMeals(let minutes):
            return "< \(minutes) min"
        case .difficulty(let level):
            return level
        case .dietary(let type):
            return type
        case .cuisine(let name):
            return name
        }
    }
}

class RecipeFilterManager {
    static let shared = RecipeFilterManager()
    
    private init() {}
    
    // MARK: - Apply Single Filter
    
    func applyFilter(_ filter: RecipeFilter, to recipes: [Recipe]) -> [Recipe] {
        switch filter {
        case .quickMeals(let maxMinutes):
            return recipes.filter { $0.time <= maxMinutes }
            
        case .difficulty(let level):
            return recipes.filter { $0.difficulty.lowercased() == level.lowercased() }
            
        case .dietary(let type):
            return recipes.filter { recipe in
                // Check if recipe tags contain dietary preference
                recipe.tags.contains { $0.lowercased() == type.lowercased() }
            }
            
        case .cuisine(let name):
            return recipes.filter { $0.cuisine.lowercased() == name.lowercased() }
        }
    }
    
    // MARK: - Apply Multiple Filters
    
    func applyFilters(_ filters: [RecipeFilter], to recipes: [Recipe]) -> [Recipe] {
        var filtered = recipes
        
        for filter in filters {
            filtered = applyFilter(filter, to: filtered)
        }
        
        return filtered
    }
    
    // MARK: - Parse Filter String
    
    func parseFilterString(_ filterString: String) -> RecipeFilter? {
        let normalized = filterString.trimmingCharacters(in: .whitespaces)
        
        if normalized.hasPrefix("<") && normalized.contains("min") {
            if let minutes = Int(normalized.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                return .quickMeals(maxMinutes: minutes)
            }
        }
        
        let difficulties = ["Easy", "Medium", "Hard", "Beginner", "Intermediate", "Advanced"]
        if difficulties.contains(where: { $0.lowercased() == normalized.lowercased() }) {
            return .difficulty(normalized)
        }
        
        let dietaryTypes = ["Vegan", "Vegetarian", "Gluten-Free", "Dairy-Free", "Keto", "Paleo"]
        if dietaryTypes.contains(where: { $0.lowercased() == normalized.lowercased() }) {
            return .dietary(normalized)
        }
        
        return .cuisine(normalized)
    }
    
    // MARK: - Apply Filter Strings
    
    func applyFilterStrings(_ filterStrings: [String], to recipes: [Recipe]) -> [Recipe] {
        let filters = filterStrings.compactMap { parseFilterString($0) }
        return applyFilters(filters, to: recipes)
    }
}
