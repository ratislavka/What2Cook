//
//  HelpVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class HelpVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    

    private let subtitleLabel = WTBodyLabel(textalignment: .left)
    private let searchBar = UISearchBar()
    
    private let essentialTipsStack = UIStackView()
    private let foodStorageContainer = UIView()
    private let foodStorageStack = UIStackView()
    private let measurementContainer = UIView()
    private let measurementStack = UIStackView()
    private let learnMoreStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Help && Tips"
        
        
        configureScrollView()
        configureTitleSection()
        configureSearchBar()
        configureEssentialTips()
        configureFoodStorage()
        configureMeasurementConversions()
        configureLearnMore()
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
    
    private func configureTitleSection() {
        subtitleLabel.text = "Cooking guides and helpful advice"
        subtitleLabel.textColor = .secondaryLabel
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Search help topics..."
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureEssentialTips() {
        let sectionHeader = createSectionHeader(icon: "👨‍🍳", title: "Essential Cooking Tips")
        contentView.addSubview(sectionHeader)
        
        essentialTipsStack.axis = .vertical
        essentialTipsStack.spacing = 12
        essentialTipsStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(essentialTipsStack)
        
        for tip in tips {
            let tipView = createTipCard(tip: tip)
            essentialTipsStack.addArrangedSubview(tipView)
        }
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            sectionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            essentialTipsStack.topAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 12),
            essentialTipsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            essentialTipsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureFoodStorage() {
        let sectionHeader = createSectionHeader(icon: "🍽️", title: "Food Storage Guide")
        contentView.addSubview(sectionHeader)
   
        foodStorageContainer.applyCardStyle()
        foodStorageContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodStorageContainer)
        
        foodStorageStack.axis = .vertical
        foodStorageStack.spacing = 0
        foodStorageStack.translatesAutoresizingMaskIntoConstraints = false
        foodStorageContainer.addSubview(foodStorageStack)
    
        
        for (index, item) in storageItems.enumerated() {
            let itemView = createStorageRow(item: item, showDivider: index < storageItems.count - 1)
            foodStorageStack.addArrangedSubview(itemView)
        }
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: essentialTipsStack.bottomAnchor, constant: 32),
            sectionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            foodStorageContainer.topAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 12),
            foodStorageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            foodStorageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            foodStorageStack.topAnchor.constraint(equalTo: foodStorageContainer.topAnchor),
            foodStorageStack.leadingAnchor.constraint(equalTo: foodStorageContainer.leadingAnchor),
            foodStorageStack.trailingAnchor.constraint(equalTo: foodStorageContainer.trailingAnchor),
            foodStorageStack.bottomAnchor.constraint(equalTo: foodStorageContainer.bottomAnchor)
        ])
    }
    
    private func configureMeasurementConversions() {
        let sectionHeader = createSectionHeader(icon: "⚖️", title: "Measurement Conversions")
        contentView.addSubview(sectionHeader)
        
        measurementContainer.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.08)
        measurementContainer.layer.cornerRadius = 12
        measurementContainer.layer.borderWidth = 1
        measurementContainer.layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.2).cgColor
        measurementContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(measurementContainer)
        
        measurementStack.axis = .vertical
        measurementStack.spacing = 0
        measurementStack.translatesAutoresizingMaskIntoConstraints = false
        measurementContainer.addSubview(measurementStack)

        
        for (index, conversion) in conversions.enumerated() {
            let row = createConversionRow(conversion: conversion, showDivider: index < conversions.count - 1)
            measurementStack.addArrangedSubview(row)
        }
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: foodStorageContainer.bottomAnchor, constant: 32),
            sectionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            measurementContainer.topAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 12),
            measurementContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            measurementContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            measurementStack.topAnchor.constraint(equalTo: measurementContainer.topAnchor, constant: 12),
            measurementStack.leadingAnchor.constraint(equalTo: measurementContainer.leadingAnchor, constant: 16),
            measurementStack.trailingAnchor.constraint(equalTo: measurementContainer.trailingAnchor, constant: -16),
            measurementStack.bottomAnchor.constraint(equalTo: measurementContainer.bottomAnchor, constant: -12)
        ])
    }
    
    private func configureLearnMore() {
        let sectionHeader = createSectionHeader(icon: "📖", title: "Learn More")
        contentView.addSubview(sectionHeader)
        
        learnMoreStack.axis = .vertical
        learnMoreStack.spacing = 12
        learnMoreStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(learnMoreStack)
        
        
        for guide in guides {
            let guideView = createGuideCard(guide: guide)
            learnMoreStack.addArrangedSubview(guideView)
        }
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: measurementContainer.bottomAnchor, constant: 32),
            sectionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            learnMoreStack.topAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 12),
            learnMoreStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            learnMoreStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            learnMoreStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    // MARK: - Helper Methods
    
    private func createSectionHeader(icon: String, title: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 20)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(iconLabel)
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return container
    }
    
    private func createTipCard(tip: CookingTip) -> UIView {
        let container = UIView()
        container.applyCardStyle()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContainer = UIView()
        iconContainer.backgroundColor = tip.iconBg
        iconContainer.layer.cornerRadius = 8
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = tip.icon
        iconLabel.font = .systemFont(ofSize: 24)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = tip.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = tip.description
        descLabel.font = .systemFont(ofSize: 14)
        descLabel.textColor = .secondaryLabel
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(iconLabel)
        container.addSubview(iconContainer)
        container.addSubview(titleLabel)
        container.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            iconContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            iconLabel.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        return container
    }
    
    private func createStorageRow(item: StorageItem, showDivider: Bool) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = item.name
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let locationLabel = UILabel()
        locationLabel.text = item.location
        locationLabel.font = .systemFont(ofSize: 13)
        locationLabel.textColor = .secondaryLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let durationLabel = UILabel()
        durationLabel.text = item.duration
        durationLabel.font = .systemFont(ofSize: 14, weight: .medium)
        durationLabel.textColor = item.durationColor
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(nameLabel)
        container.addSubview(locationLabel)
        container.addSubview(durationLabel)
        
        if showDivider {
            let divider = UIView()
            divider.backgroundColor = .separator
            divider.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(divider)
            
            NSLayoutConstraint.activate([
                divider.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                divider.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
                divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                divider.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: durationLabel.leadingAnchor, constant: -12),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            locationLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            
            durationLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 70)
        ])
        
        return container
    }
    
    private func createConversionRow(conversion: MeasurementConversion, showDivider: Bool) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let fromLabel = UILabel()
        fromLabel.text = conversion.from
        fromLabel.font = .systemFont(ofSize: 16)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let separatorLabel = UILabel()
        separatorLabel.text = "—"
        separatorLabel.font = .systemFont(ofSize: 16)
        separatorLabel.textColor = .systemOrange
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let toLabel = UILabel()
        toLabel.text = conversion.to
        toLabel.font = .systemFont(ofSize: 16, weight: .medium)
        toLabel.textColor = .systemOrange
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(fromLabel)
        container.addSubview(separatorLabel)
        container.addSubview(toLabel)
        

        if showDivider {
            let divider = UIView()
            divider.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.2)
            divider.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(divider)
            
            NSLayoutConstraint.activate([
                divider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                divider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                divider.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        }
        
        NSLayoutConstraint.activate([
            fromLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            fromLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            toLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            toLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            separatorLabel.trailingAnchor.constraint(equalTo: toLabel.leadingAnchor, constant: -8),
            separatorLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return container
    }
    
    private func createGuideCard(guide: GuideItem) -> UIView {
        let container = UIView()
        container.applyCardStyle()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContainer = UIView()
        iconContainer.backgroundColor = guide.iconColor.withAlphaComponent(0.15)
        iconContainer.layer.cornerRadius = 8
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = guide.icon
        iconLabel.font = .systemFont(ofSize: 24)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = guide.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .secondaryLabel
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(iconLabel)
        container.addSubview(iconContainer)
        container.addSubview(titleLabel)
        container.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 48),
            iconContainer.heightAnchor.constraint(equalToConstant: 48),
            
            iconLabel.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            chevron.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 12),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            
            container.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        return container
    }
}

// MARK: - Data Models

struct CookingTip {
    let icon: String
    let iconBg: UIColor
    let title: String
    let description: String
}

struct StorageItem {
    let name: String
    let location: String
    let duration: String
    let durationColor: UIColor
}

struct MeasurementConversion {
    let from: String
    let to: String
}

struct GuideItem {
    let icon: String
    let title: String
    let iconColor: UIColor
}
