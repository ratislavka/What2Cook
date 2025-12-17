//
//  ShoppingListManager.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 17.12.2025.
//

import Foundation

struct ShoppingItem: Codable, Identifiable {
    let id: UUID
    var name: String
    var amount: String
    var isChecked: Bool
    let dateAdded: Date
    var category: String
    
    init(name: String, amount: String, category: String = "Other") {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.isChecked = false
        self.dateAdded = Date()
        self.category = category
    }
}

class ShoppingListManager {
    static let shared = ShoppingListManager()
    
    private let userDefaultsKey = "shoppingList"
    private var items: [ShoppingItem] = []
    
    private var observers: [(([ShoppingItem]) -> Void)] = []
    
    private init() {
        loadItems()
    }
    
    // MARK: - Get Items
    
    func getAllItems() -> [ShoppingItem] {
        return items
    }
    
    func getUncheckedItems() -> [ShoppingItem] {
        return items.filter { !$0.isChecked }
    }
    
    func getCheckedItems() -> [ShoppingItem] {
        return items.filter { $0.isChecked }
    }
    
    func getItemsByCategory() -> [String: [ShoppingItem]] {
        return Dictionary(grouping: items, by: { $0.category })
    }
    
    // MARK: - Add Items
    
    func addItem(_ item: ShoppingItem) {
        items.append(item)
        saveItems()
        notifyObservers()
    }
    
    func addItem(name: String, amount: String, category: String = "Other") {
        let item = ShoppingItem(name: name, amount: amount, category: category)
        addItem(item)
    }
    
    func addMissingIngredients(from recipe: Recipe, matchResult: RecipeMatchResult) {
        for ingredient in matchResult.missingIngredients {
            let alreadyExists = items.contains { $0.name.lowercased() == ingredient.name.lowercased() }
            
            if !alreadyExists {
                let category = categorizeIngredient(ingredient.name)
                let item = ShoppingItem(name: ingredient.name, amount: ingredient.amount, category: category)
                items.append(item)
            }
        }
        saveItems()
        notifyObservers()
    }
    
    private func categorizeIngredient(_ name: String) -> String {
        let lower = name.lowercased()
        
        if lower.contains("chicken") || lower.contains("beef") || lower.contains("pork") || lower.contains("fish") {
            return "Meat & Seafood"
        } else if lower.contains("milk") || lower.contains("cheese") || lower.contains("yogurt") || lower.contains("butter") {
            return "Dairy"
        } else if lower.contains("apple") || lower.contains("banana") || lower.contains("orange") || lower.contains("berry") {
            return "Fruits"
        } else if lower.contains("lettuce") || lower.contains("tomato") || lower.contains("onion") || lower.contains("pepper") {
            return "Vegetables"
        } else if lower.contains("bread") || lower.contains("pasta") || lower.contains("rice") {
            return "Grains & Bread"
        } else {
            return "Other"
        }
    }
    
    // MARK: - Update Items
    
    func toggleCheck(_ item: ShoppingItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isChecked.toggle()
            saveItems()
            notifyObservers()
        }
    }
    
    func updateItem(_ item: ShoppingItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveItems()
            notifyObservers()
        }
    }
    
    // MARK: - Delete Items
    
    func deleteItem(_ item: ShoppingItem) {
        items.removeAll { $0.id == item.id }
        saveItems()
        notifyObservers()
    }
    
    func deleteCheckedItems() {
        items.removeAll { $0.isChecked }
        saveItems()
        notifyObservers()
    }
    
    func clearAll() {
        items.removeAll()
        saveItems()
        notifyObservers()
    }
    
    // MARK: - Persistence
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([ShoppingItem].self, from: data) {
            self.items = decoded
        }
    }
    
    // MARK: - Observer Pattern
    
    func addObserver(_ observer: @escaping ([ShoppingItem]) -> Void) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        observers.forEach { $0(items) }
    }
}
