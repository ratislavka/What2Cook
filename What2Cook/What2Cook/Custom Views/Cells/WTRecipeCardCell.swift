//
//  WTRecipeCardCell.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 09.12.2025.
//

import UIKit

class WTRecipeCardCell: UITableViewCell {
    
    static let reuseID = "WTRecipeCardCell"
    
    private let cardView = UIView()
    private let recipeImageView = UIImageView()
    private let cuisineLabel = UILabel()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let difficultyLabel = UILabel()
    private let ingredientsTextLabel = UILabel()
    private let ingredientsPercentLabel = UILabel()
    private let progressView = UIProgressView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe, availabilityPercentage: Int = 0) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        cuisineLabel.text = recipe.cuisine
        nameLabel.text = recipe.name
        timeLabel.text = "\(recipe.time) min"
        difficultyLabel.text = recipe.difficulty
        
        ingredientsPercentLabel.text = "\(availabilityPercentage)%"
        progressView.progress = Float(availabilityPercentage) / 100.0
        
        if availabilityPercentage == 100 {
            progressView.progressTintColor = .systemGreen
            ingredientsPercentLabel.textColor = .systemGreen
        } else if availabilityPercentage >= 50 {
            progressView.progressTintColor = .systemOrange
            ingredientsPercentLabel.textColor = .systemOrange
        } else {
            progressView.progressTintColor = .systemRed
            ingredientsPercentLabel.textColor = .systemRed
        }
    }
    
    private func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(recipeImageView)
        
        cuisineLabel.font = .systemFont(ofSize: 12, weight: .medium)
        cuisineLabel.textColor = .label
        cuisineLabel.backgroundColor = .systemBackground
        cuisineLabel.layer.cornerRadius = 12
        cuisineLabel.clipsToBounds = true
        cuisineLabel.textAlignment = .center
        cuisineLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.addSubview(cuisineLabel)
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)
        
        let timeIcon = UIImageView(image: UIImage(systemName: "clock"))
        timeIcon.tintColor = .systemOrange
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .secondaryLabel
        
        let diffIcon = UIImageView(image: UIImage(systemName: "chart.bar"))
        diffIcon.tintColor = .systemOrange
        diffIcon.translatesAutoresizingMaskIntoConstraints = false
        
        difficultyLabel.font = .systemFont(ofSize: 14)
        difficultyLabel.textColor = .systemOrange
        
        let timeStack = UIStackView(arrangedSubviews: [timeIcon, timeLabel])
        timeStack.axis = .horizontal
        timeStack.spacing = 4
        
        let diffStack = UIStackView(arrangedSubviews: [diffIcon, difficultyLabel])
        diffStack.axis = .horizontal
        diffStack.spacing = 4
        
        let infoStack = UIStackView(arrangedSubviews: [timeStack, diffStack])
        infoStack.axis = .horizontal
        infoStack.spacing = 16
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(infoStack)
        
        ingredientsTextLabel.text = "Ingredients available"
        ingredientsTextLabel.font = .systemFont(ofSize: 14)
        ingredientsTextLabel.textColor = .secondaryLabel
        ingredientsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(ingredientsTextLabel)
        
        ingredientsPercentLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        ingredientsPercentLabel.textColor = .systemOrange
        ingredientsPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(ingredientsPercentLabel)
        
        progressView.progressTintColor = .systemOrange
        progressView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            recipeImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 160),
            
            cuisineLabel.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -12),
            cuisineLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 12),
            cuisineLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            cuisineLabel.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            infoStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            
            timeIcon.widthAnchor.constraint(equalToConstant: 16),
            timeIcon.heightAnchor.constraint(equalToConstant: 16),
            diffIcon.widthAnchor.constraint(equalToConstant: 16),
            diffIcon.heightAnchor.constraint(equalToConstant: 16),
            
            ingredientsTextLabel.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 12),
            ingredientsTextLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            
            ingredientsPercentLabel.centerYAnchor.constraint(equalTo: ingredientsTextLabel.centerYAnchor),
            ingredientsPercentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            progressView.topAnchor.constraint(equalTo: ingredientsTextLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
}
