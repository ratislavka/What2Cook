//
//  Recipes.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

let recipes: [Recipe] = [
    // ITALIAN
    Recipe(
        name: "Pasta Carbonara",
        time: 25,
        difficulty: "Medium",
        cuisine: "Italian",
        ingredientsAvailable: 0,
        imageName: "carbonara",
        servings: 4,
        ingredients: [
            Recipe.Ingredient(name: "Spaghetti", amount: "400g", isAvailable: false),
            Recipe.Ingredient(name: "Pancetta", amount: "200g", isAvailable: false),
            Recipe.Ingredient(name: "Eggs", amount: "4", isAvailable: false),
            Recipe.Ingredient(name: "Parmesan cheese", amount: "100g", isAvailable: false),
            Recipe.Ingredient(name: "Black pepper", amount: "1 tsp", isAvailable: false)
        ],
        steps: [
            "Bring a large pot of salted water to boil. Cook spaghetti according to package directions.",
            "Dice the pancetta and cook in a large skillet over medium heat until crispy.",
            "In a bowl, whisk together eggs and grated Parmesan cheese. Season with black pepper.",
            "Drain pasta, add to skillet with pancetta, remove from heat.",
            "Stir in egg mixture, adding pasta water as needed for creamy sauce.",
            "Serve immediately with extra Parmesan."
        ],
        tags: ["dinner", "italian"]
    ),
    
    Recipe(
        name: "Margherita Pizza",
        time: 35,
        difficulty: "Easy",
        cuisine: "Italian",
        ingredientsAvailable: 0,
        imageName: "pizza",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Pizza dough", amount: "1 ball", isAvailable: false),
            Recipe.Ingredient(name: "Tomato sauce", amount: "1/2 cup", isAvailable: false),
            Recipe.Ingredient(name: "Fresh mozzarella", amount: "200g", isAvailable: false),
            Recipe.Ingredient(name: "Fresh basil", amount: "handful", isAvailable: false),
            Recipe.Ingredient(name: "Olive oil", amount: "2 tbsp", isAvailable: false)
        ],
        steps: [
            "Preheat oven to 475°F. Place pizza stone if using.",
            "Roll out dough on floured surface.",
            "Spread tomato sauce evenly, leaving 1-inch border.",
            "Distribute mozzarella pieces over sauce.",
            "Drizzle with olive oil and bake 12-15 minutes.",
            "Top with fresh basil and serve."
        ],
        tags: ["dinner", "italian", "easy"]
    ),
    
    // MEXICAN
    Recipe(
        name: "Chicken Tacos",
        time: 20,
        difficulty: "Easy",
        cuisine: "Mexican",
        ingredientsAvailable: 0,
        imageName: "tacos",
        servings: 4,
        ingredients: [
            Recipe.Ingredient(name: "Chicken Breast", amount: "500g", isAvailable: false),
            Recipe.Ingredient(name: "Taco seasoning", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Tortillas", amount: "8", isAvailable: false),
            Recipe.Ingredient(name: "Lettuce", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Tomatoes", amount: "2", isAvailable: false),
            Recipe.Ingredient(name: "Cheddar Cheese", amount: "100g", isAvailable: false)
        ],
        steps: [
            "Cut chicken into bite-sized pieces.",
            "Cook chicken in skillet with taco seasoning until done.",
            "Warm tortillas in another pan or microwave.",
            "Chop lettuce and tomatoes.",
            "Assemble tacos with chicken, vegetables, and cheese.",
            "Serve with sour cream and salsa if desired."
        ],
        tags: ["dinner", "mexican", "easy"]
    ),
    
    // AMERICAN BREAKFAST
    Recipe(
        name: "Pancakes",
        time: 15,
        difficulty: "Easy",
        cuisine: "American",
        ingredientsAvailable: 0,
        imageName: "pancakes",
        servings: 4,
        ingredients: [
            Recipe.Ingredient(name: "Flour", amount: "2 cups", isAvailable: false),
            Recipe.Ingredient(name: "Milk", amount: "1.5 cups", isAvailable: false),
            Recipe.Ingredient(name: "Eggs", amount: "2", isAvailable: false),
            Recipe.Ingredient(name: "Butter", amount: "3 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Sugar", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Baking powder", amount: "2 tsp", isAvailable: false)
        ],
        steps: [
            "Mix flour, sugar, baking powder in a bowl.",
            "Whisk milk, eggs, and melted butter in another bowl.",
            "Combine wet and dry ingredients until just mixed.",
            "Heat griddle or pan over medium heat.",
            "Pour 1/4 cup batter for each pancake.",
            "Cook until bubbles form, flip, cook until golden."
        ],
        tags: ["breakfast", "american", "easy"]
    ),
    
    Recipe(
        name: "Scrambled Eggs",
        time: 10,
        difficulty: "Easy",
        cuisine: "American",
        ingredientsAvailable: 0,
        imageName: "eggs",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Eggs", amount: "6", isAvailable: false),
            Recipe.Ingredient(name: "Butter", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Milk", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Salt", amount: "to taste", isAvailable: false)
        ],
        steps: [
            "Crack eggs into bowl, add milk and salt.",
            "Whisk until well combined.",
            "Melt butter in non-stick pan over medium-low heat.",
            "Pour in eggs, let sit for 20 seconds.",
            "Gently stir with spatula, creating large curds.",
            "Remove from heat when still slightly wet, serve immediately."
        ],
        tags: ["breakfast", "american", "easy"]
    ),
    
    // ASIAN
    Recipe(
        name: "Fried Rice",
        time: 20,
        difficulty: "Easy",
        cuisine: "Chinese",
        ingredientsAvailable: 0,
        imageName: "fried-rice",
        servings: 4,
        ingredients: [
            Recipe.Ingredient(name: "Cooked rice", amount: "4 cups", isAvailable: false),
            Recipe.Ingredient(name: "Eggs", amount: "2", isAvailable: false),
            Recipe.Ingredient(name: "Carrots", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Peas", amount: "1/2 cup", isAvailable: false),
            Recipe.Ingredient(name: "Soy sauce", amount: "3 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Green onions", amount: "2", isAvailable: false)
        ],
        steps: [
            "Heat oil in large wok or skillet over high heat.",
            "Scramble eggs and set aside.",
            "Stir-fry diced carrots and peas until tender.",
            "Add rice, breaking up clumps.",
            "Add soy sauce and scrambled eggs.",
            "Toss everything together, garnish with green onions."
        ],
        tags: ["dinner", "chinese", "easy"]
    ),
    
    // VEGAN OPTIONS
    Recipe(
        name: "Buddha Bowl",
        time: 30,
        difficulty: "Easy",
        cuisine: "Mediterranean",
        ingredientsAvailable: 0,
        imageName: "buddha-bowl",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Quinoa", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Chickpeas", amount: "1 can", isAvailable: false),
            Recipe.Ingredient(name: "Sweet potato", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Kale", amount: "2 cups", isAvailable: false),
            Recipe.Ingredient(name: "Avocado", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Tahini", amount: "2 tbsp", isAvailable: false)
        ],
        steps: [
            "Cook quinoa according to package instructions.",
            "Roast cubed sweet potato at 400°F for 25 minutes.",
            "Drain and rinse chickpeas, roast with spices.",
            "Massage kale with lemon juice.",
            "Assemble bowls with quinoa base.",
            "Top with all ingredients and drizzle with tahini dressing."
        ],
        tags: ["lunch", "dinner", "vegan", "mediterranean"]
    ),
    
    // FRENCH
    Recipe(
        name: "French Omelette",
        time: 10,
        difficulty: "Medium",
        cuisine: "French",
        ingredientsAvailable: 0,
        imageName: "omelette",
        servings: 1,
        ingredients: [
            Recipe.Ingredient(name: "Eggs", amount: "3", isAvailable: false),
            Recipe.Ingredient(name: "Butter", amount: "1 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Cheese", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Herbs", amount: "1 tsp", isAvailable: false)
        ],
        steps: [
            "Beat eggs with herbs until well combined.",
            "Melt butter in non-stick pan over medium heat.",
            "Pour eggs, let sit for 30 seconds.",
            "Gently push edges toward center, tilting pan.",
            "When almost set, add cheese to one half.",
            "Fold in half and slide onto plate."
        ],
        tags: ["breakfast", "french"]
    ),
    
    // THAI
    Recipe(
        name: "Pad Thai",
        time: 30,
        difficulty: "Medium",
        cuisine: "Thai",
        ingredientsAvailable: 0,
        imageName: "pad-thai",
        servings: 4,
        ingredients: [
            Recipe.Ingredient(name: "Rice noodles", amount: "400g", isAvailable: false),
            Recipe.Ingredient(name: "Chicken Breast", amount: "300g", isAvailable: false),
            Recipe.Ingredient(name: "Eggs", amount: "2", isAvailable: false),
            Recipe.Ingredient(name: "Bean sprouts", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Peanuts", amount: "1/4 cup", isAvailable: false),
            Recipe.Ingredient(name: "Tamarind paste", amount: "2 tbsp", isAvailable: false)
        ],
        steps: [
            "Soak rice noodles in warm water for 30 minutes.",
            "Cut chicken into thin strips and cook in wok.",
            "Push chicken aside, scramble eggs.",
            "Add drained noodles and sauce mixture.",
            "Toss everything together over high heat.",
            "Serve with bean sprouts, peanuts, and lime wedges."
        ],
        tags: ["dinner", "thai"]
    ),
    
    // INDIAN
    Recipe(
        name: "Butter Chicken",
        time: 45,
        difficulty: "Medium",
        cuisine: "Indian",
        ingredientsAvailable: 0,
        imageName: "butter-chicken",
        servings: 6,
        ingredients: [
            Recipe.Ingredient(name: "Chicken Breast", amount: "1kg", isAvailable: false),
            Recipe.Ingredient(name: "Tomato sauce", amount: "2 cups", isAvailable: false),
            Recipe.Ingredient(name: "Heavy cream", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Butter", amount: "4 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Garam masala", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Ginger", amount: "1 tbsp", isAvailable: false)
        ],
        steps: [
            "Marinate chicken in yogurt and spices for 30 minutes.",
            "Cook chicken in butter until browned.",
            "Add tomato sauce, cream, and spices.",
            "Simmer for 20 minutes until thick.",
            "Stir in butter at the end.",
            "Serve with rice or naan bread."
        ],
        tags: ["dinner", "indian"]
    ),
    // MEDITERRANEAN
    Recipe(
        name: "Greek Salad",
        time: 10,
        difficulty: "Easy",
        cuisine: "Greek",
        ingredientsAvailable: 0,
        imageName: "greek-salad",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Tomatoes", amount: "3", isAvailable: false),
            Recipe.Ingredient(name: "Cucumber", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Feta Cheese", amount: "150g", isAvailable: false),
            Recipe.Ingredient(name: "Olive Oil", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Oregano", amount: "1 tsp", isAvailable: false)
        ],
        steps: [
            "Chop tomatoes and cucumber.",
            "Combine vegetables in a bowl.",
            "Add feta cheese chunks.",
            "Drizzle with olive oil.",
            "Sprinkle oregano and toss gently.",
            "Serve fresh."
        ],
        tags: ["lunch", "salad", "easy", "mediterranean"]
    ),

    // ITALIAN
    Recipe(
        name: "Tomato Basil Pasta",
        time: 20,
        difficulty: "Easy",
        cuisine: "Italian",
        ingredientsAvailable: 0,
        imageName: "tomato-pasta",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Pasta", amount: "250g", isAvailable: false),
            Recipe.Ingredient(name: "Tomato Sauce", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Garlic", amount: "2 cloves", isAvailable: false),
            Recipe.Ingredient(name: "Basil", amount: "handful", isAvailable: false),
            Recipe.Ingredient(name: "Olive Oil", amount: "2 tbsp", isAvailable: false)
        ],
        steps: [
            "Cook pasta according to package instructions.",
            "Heat olive oil and sauté garlic.",
            "Add tomato sauce and simmer for 5 minutes.",
            "Toss pasta with sauce.",
            "Top with fresh basil.",
            "Serve warm."
        ],
        tags: ["dinner", "italian", "easy"]
    ),

    // AMERICAN
    Recipe(
        name: "Grilled Cheese Sandwich",
        time: 10,
        difficulty: "Easy",
        cuisine: "American",
        ingredientsAvailable: 0,
        imageName: "grilled-cheese",
        servings: 1,
        ingredients: [
            Recipe.Ingredient(name: "Bread", amount: "2 slices", isAvailable: false),
            Recipe.Ingredient(name: "Cheddar Cheese", amount: "2 slices", isAvailable: false),
            Recipe.Ingredient(name: "Butter", amount: "1 tbsp", isAvailable: false)
        ],
        steps: [
            "Butter one side of each bread slice.",
            "Place cheese between unbuttered sides.",
            "Cook sandwich in pan over medium heat.",
            "Flip when golden brown.",
            "Cook until cheese melts.",
            "Serve immediately."
        ],
        tags: ["lunch", "american", "easy"]
    ),

    // ASIAN
    Recipe(
        name: "Vegetable Stir Fry",
        time: 15,
        difficulty: "Easy",
        cuisine: "Asian",
        ingredientsAvailable: 0,
        imageName: "stir-fry",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Bell Pepper", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Broccoli", amount: "1 cup", isAvailable: false),
            Recipe.Ingredient(name: "Carrots", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Soy Sauce", amount: "2 tbsp", isAvailable: false),
            Recipe.Ingredient(name: "Garlic", amount: "2 cloves", isAvailable: false)
        ],
        steps: [
            "Heat oil in pan over high heat.",
            "Add garlic and sauté briefly.",
            "Add vegetables and stir fry for 5–7 minutes.",
            "Add soy sauce and toss.",
            "Cook until vegetables are tender-crisp.",
            "Serve hot."
        ],
        tags: ["dinner", "asian", "vegan", "easy"]
    ),

    // MEXICAN
    Recipe(
        name: "Guacamole",
        time: 10,
        difficulty: "Easy",
        cuisine: "Mexican",
        ingredientsAvailable: 0,
        imageName: "guacamole",
        servings: 2,
        ingredients: [
            Recipe.Ingredient(name: "Avocado", amount: "2", isAvailable: false),
            Recipe.Ingredient(name: "Lime", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Onion", amount: "1/4", isAvailable: false),
            Recipe.Ingredient(name: "Salt", amount: "to taste", isAvailable: false)
        ],
        steps: [
            "Mash avocados in a bowl.",
            "Add chopped onion.",
            "Squeeze lime juice.",
            "Season with salt.",
            "Mix gently.",
            "Serve with tortillas or chips."
        ],
        tags: ["snack", "mexican", "vegan", "easy"]
    ),

    // HEALTHY
    Recipe(
        name: "Avocado Toast",
        time: 10,
        difficulty: "Easy",
        cuisine: "International",
        ingredientsAvailable: 0,
        imageName: "avocado-toast",
        servings: 1,
        ingredients: [
            Recipe.Ingredient(name: "Bread", amount: "2 slices", isAvailable: false),
            Recipe.Ingredient(name: "Avocado", amount: "1", isAvailable: false),
            Recipe.Ingredient(name: "Salt", amount: "to taste", isAvailable: false),
            Recipe.Ingredient(name: "Olive Oil", amount: "1 tsp", isAvailable: false)
        ],
        steps: [
            "Toast bread slices.",
            "Mash avocado with salt.",
            "Spread avocado on toast.",
            "Drizzle olive oil.",
            "Serve immediately."
        ],
        tags: ["breakfast", "healthy", "easy"]
    )

]
