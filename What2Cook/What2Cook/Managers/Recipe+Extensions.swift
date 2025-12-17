//
//  Recipe+Extensions.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import Foundation


extension Recipe {
    func withUpdatedIngredientAvailability() -> Recipe {
        let updatedIngredients = self.ingredients

        return Recipe(
            name: self.name,
            time: self.time,
            difficulty: self.difficulty,
            cuisine: self.cuisine,
            ingredientsAvailable: self.ingredientsAvailable,
            imageName: self.imageName,
            servings: self.servings,
            ingredients: updatedIngredients,
            steps: self.steps,
            tags: self.tags
        )
    }
}

