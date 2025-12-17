//
//  Products.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 17.12.2025.
//

import UIKit

let allProducts: [ProductTemplate] = [

    // MARK: - Fruits
    ProductTemplate(name: "Apples", image: "apple", category: .fruits),
    ProductTemplate(name: "Bananas", image: "banana", category: .fruits),
    ProductTemplate(name: "Oranges", image: "orange", category: .fruits),
    ProductTemplate(name: "Lemons", image: "lemon", category: .fruits),
    ProductTemplate(name: "Limes", image: "lime", category: .fruits),
    ProductTemplate(name: "Strawberries", image: "strawberry", category: .fruits),
    ProductTemplate(name: "Blueberries", image: "blueberry", category: .fruits),
    ProductTemplate(name: "Raspberries", image: "raspberry", category: .fruits),
    ProductTemplate(name: "Grapes", image: "grapes", category: .fruits),
    ProductTemplate(name: "Avocado", image: "avocado", category: .fruits),
    ProductTemplate(name: "Pineapple", image: "pineapple", category: .fruits),
    ProductTemplate(name: "Mango", image: "mango", category: .fruits),

    // MARK: - Vegetables
    ProductTemplate(name: "Onions", image: "onion", category: .vegetables),
    ProductTemplate(name: "Garlic", image: "garlic", category: .vegetables),
    ProductTemplate(name: "Tomatoes", image: "tomatoes", category: .vegetables),
    ProductTemplate(name: "Cherry Tomatoes", image: "cherry-tomatoes", category: .vegetables),
    ProductTemplate(name: "Bell Pepper", image: "pepper", category: .vegetables),
    ProductTemplate(name: "Chili Pepper", image: "chili", category: .vegetables),
    ProductTemplate(name: "Carrots", image: "carrots", category: .vegetables),
    ProductTemplate(name: "Potatoes", image: "potatoes", category: .vegetables),
    ProductTemplate(name: "Sweet Potatoes", image: "sweet-potato", category: .vegetables),
    ProductTemplate(name: "Broccoli", image: "broccoli", category: .vegetables),
    ProductTemplate(name: "Cauliflower", image: "cauliflower", category: .vegetables),
    ProductTemplate(name: "Zucchini", image: "zucchini", category: .vegetables),
    ProductTemplate(name: "Eggplant", image: "eggplant", category: .vegetables),
    ProductTemplate(name: "Cucumber", image: "cucumber", category: .vegetables),
    ProductTemplate(name: "Lettuce", image: "lettuce", category: .vegetables),
    ProductTemplate(name: "Spinach", image: "spinach", category: .vegetables),
    ProductTemplate(name: "Kale", image: "kale", category: .vegetables),
    ProductTemplate(name: "Mushrooms", image: "mushrooms", category: .vegetables),

    // MARK: - Meat & Poultry
    ProductTemplate(name: "Chicken Breast", image: "chicken-breast", category: .meat),
    ProductTemplate(name: "Chicken Thighs", image: "chicken-thigh", category: .meat),
    ProductTemplate(name: "Ground Beef", image: "ground-beef", category: .meat),
    ProductTemplate(name: "Beef Steak", image: "steak", category: .meat),
    ProductTemplate(name: "Pork Chops", image: "pork-chop", category: .meat),
    ProductTemplate(name: "Bacon", image: "bacon", category: .meat),
    ProductTemplate(name: "Sausages", image: "sausages", category: .meat),

    // MARK: - Seafood
    ProductTemplate(name: "Salmon", image: "salmon", category: .seafood),
    ProductTemplate(name: "Tuna", image: "tuna", category: .seafood),
    ProductTemplate(name: "Shrimp", image: "shrimp", category: .seafood),
    ProductTemplate(name: "White Fish", image: "white-fish", category: .seafood),

    // MARK: - Eggs & Plant Protein
    ProductTemplate(name: "Eggs", image: "eggs", category: .protein),
    ProductTemplate(name: "Tofu", image: "tofu", category: .protein),
    ProductTemplate(name: "Lentils", image: "lentils", category: .protein),
    ProductTemplate(name: "Chickpeas", image: "chickpeas", category: .protein),
    ProductTemplate(name: "Black Beans", image: "black-beans", category: .protein),
    ProductTemplate(name: "Kidney Beans", image: "kidney-beans", category: .protein),

    // MARK: - Dairy & Alternatives
    ProductTemplate(name: "Milk", image: "milk", category: .dairy),
    ProductTemplate(name: "Butter", image: "butter", category: .dairy),
    ProductTemplate(name: "Cheese", image: "cheese", category: .dairy),
    ProductTemplate(name: "Cheddar Cheese", image: "cheddar", category: .dairy),
    ProductTemplate(name: "Mozzarella", image: "mozzarella", category: .dairy),
    ProductTemplate(name: "Parmesan", image: "parmesan", category: .dairy),
    ProductTemplate(name: "Yogurt", image: "yogurt", category: .dairy),
    ProductTemplate(name: "Greek Yogurt", image: "greek-yogurt", category: .dairy),
    ProductTemplate(name: "Cream", image: "cream", category: .dairy),

    // MARK: - Grains & Pasta
    ProductTemplate(name: "Rice", image: "rice", category: .grains),
    ProductTemplate(name: "Brown Rice", image: "brown-rice", category: .grains),
    ProductTemplate(name: "Pasta", image: "pasta", category: .grains),
    ProductTemplate(name: "Spaghetti", image: "spaghetti", category: .grains),
    ProductTemplate(name: "Quinoa", image: "quinoa", category: .grains),
    ProductTemplate(name: "Oats", image: "oats", category: .grains),
    ProductTemplate(name: "Couscous", image: "couscous", category: .grains),

    // MARK: - Bakery
    ProductTemplate(name: "Bread", image: "bread", category: .bakery),
    ProductTemplate(name: "Baguette", image: "baguette", category: .bakery),
    ProductTemplate(name: "Tortillas", image: "tortillas", category: .bakery),
    ProductTemplate(name: "Bagels", image: "bagels", category: .bakery),
    ProductTemplate(name: "Burger Buns", image: "buns", category: .bakery),

    // MARK: - Pantry & Oils
    ProductTemplate(name: "Olive Oil", image: "olive-oil", category: .pantry),
    ProductTemplate(name: "Vegetable Oil", image: "vegetable-oil", category: .pantry),
    ProductTemplate(name: "Salt", image: "salt", category: .pantry),
    ProductTemplate(name: "Black Pepper", image: "pepper-spice", category: .pantry),
    ProductTemplate(name: "Sugar", image: "sugar", category: .pantry),
    ProductTemplate(name: "Honey", image: "honey", category: .pantry),
    ProductTemplate(name: "Flour", image: "flour", category: .pantry),

    // MARK: - Sauces & Condiments
    ProductTemplate(name: "Tomato Sauce", image: "tomato-sauce", category: .sauces),
    ProductTemplate(name: "Soy Sauce", image: "soy-sauce", category: .sauces),
    ProductTemplate(name: "Ketchup", image: "ketchup", category: .sauces),
    ProductTemplate(name: "Mustard", image: "mustard", category: .sauces),
    ProductTemplate(name: "Mayonnaise", image: "mayonnaise", category: .sauces),
    ProductTemplate(name: "Vinegar", image: "vinegar", category: .sauces),
    ProductTemplate(name: "Hot Sauce", image: "hot-sauce", category: .sauces),

    // MARK: - Herbs & Spices
    ProductTemplate(name: "Basil", image: "basil", category: .spices),
    ProductTemplate(name: "Oregano", image: "oregano", category: .spices),
    ProductTemplate(name: "Paprika", image: "paprika", category: .spices),
    ProductTemplate(name: "Cumin", image: "cumin", category: .spices),
    ProductTemplate(name: "Cinnamon", image: "cinnamon", category: .spices),
    ProductTemplate(name: "Parsley", image: "parsley", category: .spices),
]
