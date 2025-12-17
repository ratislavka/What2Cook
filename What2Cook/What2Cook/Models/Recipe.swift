//
//  Recipe.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

struct Recipe {
    let name: String
    let time: Int
    let difficulty: String
    let cuisine: String
    let ingredientsAvailable: Int
    let imageName: String
    
    let servings: Int
    var ingredients: [Ingredient]
    let steps: [String]
    let tags: [String]
    
    struct Ingredient {
        let name: String
        let amount: String
        var isAvailable: Bool
    }
}
