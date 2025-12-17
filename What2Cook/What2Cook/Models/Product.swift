//
//  Product.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

struct ProductTemplate {
    let name: String
    let image: String
    let category: ProductCategory
}


enum ProductCategory {
    case fruits
    case vegetables
    case meat
    case seafood
    case protein
    case dairy
    case grains
    case bakery
    case pantry
    case sauces
    case spices

    var displayName: String {
        switch self {
        case .fruits:
            return "Fruits"
        case .vegetables:
            return "Vegetables"
        case .meat:
            return "Meat"
        case .seafood:
            return "Seafood"
        case .protein:
            return "Protein"
        case .dairy:
            return "Dairy"
        case .grains:
            return "Grains"
        case .bakery:
            return "Bakery"
        case .pantry:
            return "Pantry"
        case .sauces:
            return "Sauces"
        case .spices:
            return "Spices"
        }
    }
}
