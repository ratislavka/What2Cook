//
//  RecipeDetailsVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    var recipe: Recipe?
    private let recipeService = RecipeService.shared
    private var matchResult: RecipeMatchResult?
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let recipeImageView = UIImageView()
    private let cuisineBadge = UILabel()
    private let recipeNameLabel = WTTitleLabel(textAlignment: .left, fontSize: 28)
    
    private let timeIconView = UIImageView()
    private let timeLabel = UILabel()
    private let difficultyIconView = UIImageView()
    private let difficultyLabel = UILabel()
    
    private let servingsContainerView = UIView()
    private let servingsIconView = UIImageView()
    private let servingsLabel = UILabel()
    private let decreaseButton = UIButton()
    private let servingsCountLabel = UILabel()
    private let increaseButton = UIButton()
    
    private let missingIngredientsView = UIView()
    private let missingIconView = UIImageView()
    private let missingTitleLabel = UILabel()
    private let missingItemsLabel = UILabel()
    private let addToShoppingListButton = WTButton(backgroundColor: .systemYellow, title: "Add to Shopping List", cornerStyle: .rounded)
    
    private let ingredientsSectionLabel = WTTitleLabel(textAlignment: .left, fontSize: 22)
    private let ingredientsStackView = UIStackView()
    
    private let stepsSectionLabel = WTTitleLabel(textAlignment: .left, fontSize: 22)
    private let stepsStackView = UIStackView()
    
    private let startCookingButton = WTButton(backgroundColor: .systemOrange, title: "Start Cooking", cornerStyle: .rounded)
    
//    private var currentServings: Int = recipe?.servings ?? 4
//    private var originalServings: Int = recipe?.servings ?? 4
    private var currentServings: Int = 4
    private var originalServings: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .never
        
        configureScrollView()
        configureRecipeImage()
        configureRecipeInfo()
        configureServingsSection()
        configureMissingIngredientsSection()
        configureIngredientsSection()
        configureStepsSection()
        configureStartCookingButton()
        
        if let recipe = recipe {
             matchResult = recipeService.getMatchResult(for: recipe)
             self.recipe = recipeService.getRecipeWithAvailability(recipe)
         }
        
        populateData()
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureRecipeImage() {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipeImageView)
        
        cuisineBadge.font = .systemFont(ofSize: 12, weight: .medium)
        cuisineBadge.textColor = .label
        cuisineBadge.backgroundColor = .systemBackground
        cuisineBadge.layer.cornerRadius = 12
        cuisineBadge.clipsToBounds = true
        cuisineBadge.textAlignment = .center
        cuisineBadge.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.addSubview(cuisineBadge)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 250),
            
            cuisineBadge.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -16),
            cuisineBadge.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 16),
            cuisineBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            cuisineBadge.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureRecipeInfo() {
        recipeNameLabel.numberOfLines = 0
        contentView.addSubview(recipeNameLabel)
        
        timeIconView.image = UIImage(systemName: "clock")
        timeIconView.tintColor = .systemOrange
        timeIconView.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.font = .systemFont(ofSize: 15)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        difficultyIconView.image = UIImage(systemName: "chart.bar")
        difficultyIconView.tintColor = .systemOrange
        difficultyIconView.translatesAutoresizingMaskIntoConstraints = false
        
        difficultyLabel.font = .systemFont(ofSize: 15)
        difficultyLabel.textColor = .systemOrange
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let timeStack = UIStackView(arrangedSubviews: [timeIconView, timeLabel])
        timeStack.axis = .horizontal
        timeStack.spacing = 6
        timeStack.alignment = .center
        
        let diffStack = UIStackView(arrangedSubviews: [difficultyIconView, difficultyLabel])
        diffStack.axis = .horizontal
        diffStack.spacing = 6
        diffStack.alignment = .center
        
        let infoStack = UIStackView(arrangedSubviews: [timeStack, diffStack])
        infoStack.axis = .horizontal
        infoStack.spacing = 20
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            timeIconView.widthAnchor.constraint(equalToConstant: 18),
            timeIconView.heightAnchor.constraint(equalToConstant: 18),
            difficultyIconView.widthAnchor.constraint(equalToConstant: 18),
            difficultyIconView.heightAnchor.constraint(equalToConstant: 18),
            
            infoStack.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 12),
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    private func configureServingsSection() {
        servingsContainerView.backgroundColor = .secondarySystemBackground
        servingsContainerView.layer.cornerRadius = 12
        servingsContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(servingsContainerView)
        
        servingsIconView.image = UIImage(systemName: "person.2")
        servingsIconView.tintColor = .label
        servingsIconView.translatesAutoresizingMaskIntoConstraints = false
        servingsContainerView.addSubview(servingsIconView)
        
        servingsLabel.text = "Servings"
        servingsLabel.font = .systemFont(ofSize: 15, weight: .medium)
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        servingsContainerView.addSubview(servingsLabel)
    
        decreaseButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        decreaseButton.tintColor = .systemGray
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        decreaseButton.addTarget(self, action: #selector(decreaseServings), for: .touchUpInside)
        servingsContainerView.addSubview(decreaseButton)
        
        servingsCountLabel.text = "4"
        servingsCountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        servingsCountLabel.textAlignment = .center
        servingsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        servingsContainerView.addSubview(servingsCountLabel)
        
        increaseButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        increaseButton.tintColor = .systemOrange
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.addTarget(self, action: #selector(increaseServings), for: .touchUpInside)
        servingsContainerView.addSubview(increaseButton)
        
        NSLayoutConstraint.activate([
            servingsContainerView.topAnchor.constraint(equalTo: timeIconView.bottomAnchor, constant: 20),
            servingsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            servingsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            servingsContainerView.heightAnchor.constraint(equalToConstant: 70),
            
            servingsIconView.leadingAnchor.constraint(equalTo: servingsContainerView.leadingAnchor, constant: 16),
            servingsIconView.centerYAnchor.constraint(equalTo: servingsContainerView.centerYAnchor),
            servingsIconView.widthAnchor.constraint(equalToConstant: 24),
            servingsIconView.heightAnchor.constraint(equalToConstant: 24),
            
            servingsLabel.leadingAnchor.constraint(equalTo: servingsIconView.trailingAnchor, constant: 12),
            servingsLabel.centerYAnchor.constraint(equalTo: servingsContainerView.centerYAnchor),
            
            increaseButton.trailingAnchor.constraint(equalTo: servingsContainerView.trailingAnchor, constant: -16),
            increaseButton.centerYAnchor.constraint(equalTo: servingsContainerView.centerYAnchor),
            increaseButton.widthAnchor.constraint(equalToConstant: 32),
            increaseButton.heightAnchor.constraint(equalToConstant: 32),
            
            servingsCountLabel.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -12),
            servingsCountLabel.centerYAnchor.constraint(equalTo: servingsContainerView.centerYAnchor),
            servingsCountLabel.widthAnchor.constraint(equalToConstant: 40),
            
            decreaseButton.trailingAnchor.constraint(equalTo: servingsCountLabel.leadingAnchor, constant: -12),
            decreaseButton.centerYAnchor.constraint(equalTo: servingsContainerView.centerYAnchor),
            decreaseButton.widthAnchor.constraint(equalToConstant: 32),
            decreaseButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }


    private func configureMissingIngredientsSection() {
        missingIngredientsView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.15)
        missingIngredientsView.layer.cornerRadius = 12
        missingIngredientsView.layer.borderWidth = 1.5
        missingIngredientsView.layer.borderColor = UIColor.systemYellow.cgColor
        missingIngredientsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(missingIngredientsView)
        
        missingIconView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        missingIconView.tintColor = .systemYellow
        missingIconView.translatesAutoresizingMaskIntoConstraints = false
        missingIngredientsView.addSubview(missingIconView)
        
        missingTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        missingTitleLabel.textColor = .label
        missingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        missingIngredientsView.addSubview(missingTitleLabel)
        

        missingItemsLabel.font = .systemFont(ofSize: 14)
        missingItemsLabel.textColor = .secondaryLabel
        missingItemsLabel.numberOfLines = 0
        missingItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        missingIngredientsView.addSubview(missingItemsLabel)
        
        addToShoppingListButton.translatesAutoresizingMaskIntoConstraints = false
        addToShoppingListButton.addTarget(self, action: #selector(addToShoppingListTapped), for: .touchUpInside)
        missingIngredientsView.addSubview(addToShoppingListButton)
        
        NSLayoutConstraint.activate([
            missingIngredientsView.topAnchor.constraint(equalTo: servingsContainerView.bottomAnchor, constant: 16),
            missingIngredientsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            missingIngredientsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            missingIconView.topAnchor.constraint(equalTo: missingIngredientsView.topAnchor, constant: 16),
            missingIconView.leadingAnchor.constraint(equalTo: missingIngredientsView.leadingAnchor, constant: 16),
            missingIconView.widthAnchor.constraint(equalToConstant: 24),
            missingIconView.heightAnchor.constraint(equalToConstant: 24),
            
            missingTitleLabel.topAnchor.constraint(equalTo: missingIngredientsView.topAnchor, constant: 16),
            missingTitleLabel.leadingAnchor.constraint(equalTo: missingIconView.trailingAnchor, constant: 12),
            missingTitleLabel.trailingAnchor.constraint(equalTo: missingIngredientsView.trailingAnchor, constant: -16),
            

            missingItemsLabel.topAnchor.constraint(equalTo: missingTitleLabel.bottomAnchor, constant: 8),
            missingItemsLabel.leadingAnchor.constraint(equalTo: missingIconView.trailingAnchor, constant: 12),
            missingItemsLabel.trailingAnchor.constraint(equalTo: missingIngredientsView.trailingAnchor, constant: -16),
            
            addToShoppingListButton.topAnchor.constraint(equalTo: missingItemsLabel.bottomAnchor, constant: 12),
            addToShoppingListButton.leadingAnchor.constraint(equalTo: missingIngredientsView.leadingAnchor, constant: 16),
            addToShoppingListButton.trailingAnchor.constraint(equalTo: missingIngredientsView.trailingAnchor, constant: -16),
            addToShoppingListButton.bottomAnchor.constraint(equalTo: missingIngredientsView.bottomAnchor, constant: -16),
            addToShoppingListButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func addToShoppingListTapped() {
        guard let recipe = recipe, let matchResult = matchResult else { return }
        
        ShoppingListManager.shared.addMissingIngredients(from: recipe, matchResult: matchResult)
        
        let alert = UIAlertController(
            title: "Added to Shopping List",
            message: "\(matchResult.missingIngredients.count) ingredients added",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    private func configureIngredientsSection() {
        ingredientsSectionLabel.text = "Ingredients"
        contentView.addSubview(ingredientsSectionLabel)
        
        ingredientsStackView.axis = .vertical
        ingredientsStackView.spacing = 12
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ingredientsStackView)
        
        NSLayoutConstraint.activate([
            ingredientsSectionLabel.topAnchor.constraint(equalTo: missingIngredientsView.bottomAnchor, constant: 24),
            ingredientsSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsSectionLabel.bottomAnchor, constant: 12),
            ingredientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureStepsSection() {
        stepsSectionLabel.text = "Steps"
        contentView.addSubview(stepsSectionLabel)
        
        stepsStackView.axis = .vertical
        stepsStackView.spacing = 16
        stepsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stepsStackView)
        
        NSLayoutConstraint.activate([
            stepsSectionLabel.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 24),
            stepsSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stepsSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stepsStackView.topAnchor.constraint(equalTo: stepsSectionLabel.bottomAnchor, constant: 12),
            stepsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stepsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureStartCookingButton() {
        startCookingButton.translatesAutoresizingMaskIntoConstraints = false
        startCookingButton.addTarget(self, action: #selector(startCookingTapped), for: .touchUpInside)
        contentView.addSubview(startCookingButton)
        
        NSLayoutConstraint.activate([
            startCookingButton.topAnchor.constraint(equalTo: stepsStackView.bottomAnchor, constant: 24),
            startCookingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            startCookingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            startCookingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            startCookingButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func populateData() {
        guard let recipe = recipe else { return }
        
        recipeImageView.image = UIImage(named: recipe.imageName)
        cuisineBadge.text = recipe.cuisine
        recipeNameLabel.text = recipe.name
        timeLabel.text = "\(recipe.time) min"
        difficultyLabel.text = recipe.difficulty
        
        currentServings = recipe.servings
        originalServings = recipe.servings
        servingsCountLabel.text = "\(currentServings)"
        
        
        let missingIngredients = matchResult?.missingIngredients ?? []
        
        if missingIngredients.isEmpty {
            missingIngredientsView.isHidden = true
        } else {
            missingIngredientsView.isHidden = false
            
            let bulletList = missingIngredients.map { "• \($0.name)" }.joined(separator: "\n")
            
            missingTitleLabel.text = "Missing \(missingIngredients.count) ingredient\(missingIngredients.count > 1 ? "s" : "")"
            missingItemsLabel.text = bulletList
        }
        
        updateIngredientsDisplay()
        
        for (index, step) in recipe.steps.enumerated() {
            let view = createStepRow(number: index + 1, text: step)
            stepsStackView.addArrangedSubview(view)
        }
    }

    
    private func updateIngredientsDisplay() {
        guard let recipe = recipe else { return }
        
        ingredientsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for ingredient in recipe.ingredients {
            let adjustedAmount = adjustIngredientAmount(
                original: ingredient.amount,
                originalServings: originalServings,
                newServings: currentServings
            )
            
            _ = ingredient
            // Create a new ingredient with adjusted amount (we'll use a workaround since struct is immutable)
            let view = createIngredientRow(
                name: ingredient.name,
                amount: adjustedAmount,
                isAvailable: ingredient.isAvailable
            )
            ingredientsStackView.addArrangedSubview(view)
        }
    }
    
    private func adjustIngredientAmount(original: String, originalServings: Int, newServings: Int) -> String {
        // If servings haven't changed, return original
        if originalServings == newServings {
            return original
        }
        
        let ratio = Double(newServings) / Double(originalServings)
        
        // Parse the amount - handle fractions like "1/2 cup"
        var workingString = original
        var parsedNumber: Double?
        var unit = ""
        
        // Check for fraction format (e.g., "1/2")
        if let fractionRange = workingString.range(of: #"\d+/\d+"#, options: .regularExpression) {
            let fractionStr = String(workingString[fractionRange])
            let parts = fractionStr.split(separator: "/")
            if parts.count == 2,
               let numerator = Double(parts[0]),
               let denominator = Double(parts[1]) {
                parsedNumber = numerator / denominator
                workingString.removeSubrange(fractionRange)
                unit = workingString.trimmingCharacters(in: .whitespaces)
            }
        }
        // Check for decimal/whole numbers (e.g., "400g", "2 cups")
        else if let match = workingString.range(of: #"\d+\.?\d*"#, options: .regularExpression) {
            let numberStr = String(workingString[match])
            parsedNumber = Double(numberStr)
            workingString.removeSubrange(match)
            unit = workingString.trimmingCharacters(in: .whitespaces)
        }
        
        // If we couldn't parse a number, return as-is
        guard let originalAmount = parsedNumber else {
            return original
        }
        
        // Calculate new amount
        let newAmount = originalAmount * ratio
        
        // Format the result intelligently
        let formattedAmount = formatAmount(newAmount)
        
        // Combine number and unit
        if unit.isEmpty {
            return formattedAmount
        } else {
            return "\(formattedAmount) \(unit)"
        }
    }
    
    private func formatAmount(_ amount: Double) -> String {
        // Check for common fractions first
        let fractions: [(value: Double, display: String)] = [
            (0.125, "1/8"),
            (0.25, "1/4"),
            (0.33, "1/3"),
            (0.5, "1/2"),
            (0.66, "2/3"),
            (0.75, "3/4"),
            (1.25, "1 1/4"),
            (1.33, "1 1/3"),
            (1.5, "1 1/2"),
            (1.75, "1 3/4"),
            (2.5, "2 1/2")
        ]
        
        // Check if it's close to a common fraction
        for fraction in fractions {
            if abs(amount - fraction.value) < 0.05 {
                return fraction.display
            }
        }
        
        // Whole number
        if amount.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(amount))
        }
        
        // Check if it's a whole number + common fraction
        let wholepart = floor(amount)
        let fractionalPart = amount - wholepart
        
        for fraction in fractions where fraction.value < 1 {
            if abs(fractionalPart - fraction.value) < 0.05 {
                if wholepart > 0 {
                    return "\(Int(wholepart)) \(fraction.display)"
                } else {
                    return fraction.display
                }
            }
        }
        
        // Decimal with 1 decimal place, removing trailing .0
        let formatted = String(format: "%.1f", amount)
        if formatted.hasSuffix(".0") {
            return String(Int(amount))
        }
        return formatted
    }
    
    private func createIngredientRow(name: String, amount: String, isAvailable: Bool) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 12
//        container.applyCardStyle()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = isAvailable ? .label : .systemYellow
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let amountLabel = UILabel()
        amountLabel.text = amount
        amountLabel.font = .systemFont(ofSize: 16, weight: .medium)
        amountLabel.textColor = .secondaryLabel
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(nameLabel)
        container.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -12),
            
            amountLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return container
    }
    
    private func createIngredientRow(ingredient: Recipe.Ingredient) -> UIView {
        return createIngredientRow(
            name: ingredient.name,
            amount: ingredient.amount,
            isAvailable: ingredient.isAvailable
        )
    }
    
    private func createStepRow(number: Int, text: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let numberView = UIView()
        numberView.backgroundColor = .systemOrange
        numberView.layer.cornerRadius = 18
        numberView.translatesAutoresizingMaskIntoConstraints = false
        
        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.font = .systemFont(ofSize: 16, weight: .bold)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.textColor = .secondaryLabel
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberView.addSubview(numberLabel)
        container.addSubview(numberView)
        container.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            numberView.topAnchor.constraint(equalTo: container.topAnchor),
            numberView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            numberView.widthAnchor.constraint(equalToConstant: 36),
            numberView.heightAnchor.constraint(equalToConstant: 36),
            
            numberLabel.centerXAnchor.constraint(equalTo: numberView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: numberView.centerYAnchor),
            
            textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    @objc private func decreaseServings() {
        if currentServings > 1 {
            currentServings -= 1
            servingsCountLabel.text = "\(currentServings)"
            updateIngredientsDisplay()
        }
    }
    
    @objc private func increaseServings() {
        if currentServings < 12 {
            currentServings += 1
            servingsCountLabel.text = "\(currentServings)"
            updateIngredientsDisplay()
        }
    }
    
    @objc private func startCookingTapped() {
        guard let recipe = recipe else { return }
        
        let cookingVC = CookingModeVC()
        cookingVC.recipe = recipe
        cookingVC.servings = currentServings
        navigationController?.pushViewController(cookingVC, animated: true)
    }
}
