//
//  UserDefaultsManager.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 11.12.2025.
//

import Foundation


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let hasCompletedOnboardingKey = "hasCompletedOnboarding"
    
    var hasCompletedOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasCompletedOnboardingKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasCompletedOnboardingKey)
        }
    }
}


struct UserPreferences: Codable {
    var selectedCuisines: [String]
    var dietaryRestrictions: [String]
    var skillLevel: String
    
    init(
        selectedCuisines: [String] = [],
        dietaryRestrictions: [String] = [],
        skillLevel: String = "Beginner"
    ) {
        self.selectedCuisines = selectedCuisines
        self.dietaryRestrictions = dietaryRestrictions
        self.skillLevel = skillLevel
    }
}


class UserPreferencesManager {
    static let shared = UserPreferencesManager()
    
    private let userDefaultsKey = "userPreferences"
    private var preferences: UserPreferences
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            self.preferences = decoded
        } else {
            self.preferences = UserPreferences()
        }
    }
    
    // MARK: - Get Preferences
    
    func getPreferences() -> UserPreferences {
        return preferences
    }
    
    func getCuisines() -> [String] {
        return preferences.selectedCuisines
    }
    
    func getDietaryRestrictions() -> [String] {
        return preferences.dietaryRestrictions
    }
    
    func getSkillLevel() -> String {
        return preferences.skillLevel
    }
    
    // MARK: - Update Preferences
    
    func updateCuisines(_ cuisines: [String]) {
        preferences.selectedCuisines = cuisines
        save()
    }
    
    func updateDietaryRestrictions(_ restrictions: [String]) {
        preferences.dietaryRestrictions = restrictions
        save()
    }
    
    func updateSkillLevel(_ level: String) {
        preferences.skillLevel = level
        save()
    }
    
    func updateAllPreferences(cuisines: [String], dietary: [String], skill: String) {
        preferences.selectedCuisines = cuisines
        preferences.dietaryRestrictions = dietary
        preferences.skillLevel = skill
        save()
    }
    
    // MARK: - Save to UserDefaults
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(preferences) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    // MARK: - Reset
    
    func reset() {
        preferences = UserPreferences()
        save()
    }
}
