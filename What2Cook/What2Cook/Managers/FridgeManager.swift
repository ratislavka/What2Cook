//
//  FridgeManager.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import Foundation

class FridgeManager {
    static let shared = FridgeManager()
    
    private let userDefaultsKey = "fridgeItems"
    private var items: [FridgeItem] = []
    
    private var observers: [(([FridgeItem]) -> Void)] = []
    
    private init() {
        loadItems()
    }
    
    // MARK: - Get Items
    
    func getAllItems() -> [FridgeItem] {
        return items
    }
    
    func getItemsByStorage(_ location: StorageLocation) -> [FridgeItem] {
        return items.filter { $0.storageLocation == location }
    }
    
    func getExpiringSoonItems(days: Int = 5) -> [FridgeItem] {
        return items.filter { $0.daysUntilExpiry <= days }
    }
    
    // MARK: - Add/Update/Delete
    
    func addItem(_ item: FridgeItem) {
        items.append(item)
        saveItems()
        notifyObservers()
    }
    
    func updateItem(_ item: FridgeItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveItems()
            notifyObservers()
        }
    }
    
    func deleteItem(_ item: FridgeItem) {
        items.removeAll { $0.id == item.id }
        saveItems()
        notifyObservers()
    }
    
    func deleteAllItems() {
        items.removeAll()
        saveItems()
        notifyObservers()
    }
    
    // MARK: - Check Ingredient Availability
    
    func hasIngredient(named name: String) -> Bool {
        return items.contains { $0.name.lowercased() == name.lowercased() }
    }
    
    func getAvailableIngredients() -> [String] {
        return items.map { $0.name }
    }
    
    // Check if ingredient name matches (handles partial matches)
    func findMatchingItem(for ingredientName: String) -> FridgeItem? {
        let normalized = ingredientName.lowercased().trimmingCharacters(in: .whitespaces)
        
        // Exact match first
        if let exact = items.first(where: { $0.name.lowercased() == normalized }) {
            return exact
        }
        
        // Partial match (ingredient contains fridge item name or vice versa)
        return items.first { item in
            let itemName = item.name.lowercased()
            return normalized.contains(itemName) || itemName.contains(normalized)
        }
    }
    
    // MARK: - Persistence
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([FridgeItem].self, from: data) {
            self.items = decoded
        }
    }
    
    // MARK: - Observer Pattern
    
    func addObserver(_ observer: @escaping ([FridgeItem]) -> Void) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        observers.forEach { $0(items) }
    }
}

// MARK: - Make FridgeItem Codable

extension FridgeItem: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, quantity, image, daysUntilExpiry, expiryStatus, storageLocation, expirationDate
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(image, forKey: .image)
        try container.encode(daysUntilExpiry, forKey: .daysUntilExpiry)
        try container.encode(expiryStatus.rawValue, forKey: .expiryStatus)
        try container.encode(storageLocation.rawValue, forKey: .storageLocation)
        try container.encode(expirationDate, forKey: .expirationDate)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _ = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let quantity = try container.decode(String.self, forKey: .quantity)
        let image = try container.decode(String.self, forKey: .image)
        let daysUntilExpiry = try container.decode(Int.self, forKey: .daysUntilExpiry)
        let expiryStatusRaw = try container.decode(String.self, forKey: .expiryStatus)
        let storageLocationRaw = try container.decode(String.self, forKey: .storageLocation)
        let expirationDate = try container.decode(Date.self, forKey: .expirationDate)
        
        let expiryStatus = ExpiryStatus(rawValue: expiryStatusRaw) ?? .fresh
        let storageLocation = StorageLocation(rawValue: storageLocationRaw) ?? .fridge
        
        self.init(
            name: name,
            quantity: quantity,
            image: image,
            daysUntilExpiry: daysUntilExpiry,
            expiryStatus: expiryStatus,
            storageLocation: storageLocation,
            expirationDate: expirationDate
        )
    }
}

