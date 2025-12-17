//
//  SkillLevelVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class SkillLevelVC: UIViewController {
    
    private let preferencesManager = UserPreferencesManager.shared
    private let titleLabel = WTTitleLabel(textAlignment: .center, fontSize: 25)
    private let subtitleLabel = WTBodyLabel(textalignment: .center)
    private let stepIndicatorView = StepIndicatorView(step: 3, totalSteps: 3)
    private var collectionView: UICollectionView!
    private let continueButton = WTButton(backgroundColor: .systemOrange, title: "Get Started!", cornerStyle: .rounded)
    private let backButton = WTButton(backgroundColor: .systemGray, title: "Back", cornerStyle: .rounded)
    
    private let items: [SelectableType] = [
        .init(title: "Beginner", icon: "👶"),
        .init(title: "Intermediate", icon: "👨‍🍳"),
        .init(title: "Advanced", icon: "⭐"),
    ]
    private var selectedItems = Set<SelectableType>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureStepIndicatorView()
        configureTitleLabel()
        configureSubtitleLabel()
        configureBackButton()
        configureContinueButton()
        configureCollectionView()
    }
    
    
    func hideElementsForProfile() {
        stepIndicatorView.isHidden = true
        backButton.isHidden = true
        continueButton.isHidden = true
    }
    
    
    private func configureStepIndicatorView() {
        view.addSubview(stepIndicatorView)
        
        NSLayoutConstraint.activate([
            stepIndicatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            stepIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            stepIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Your Cooking Level"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: stepIndicatorView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func configureSubtitleLabel() {
        view.addSubview(subtitleLabel)
        
        subtitleLabel.text = "Select your skill level"
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70)
        ])
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
            
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20)
        ])
        
        collectionView.register(WTSelectableCell.self, forCellWithReuseIdentifier: WTSelectableCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false 
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func previousVC() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(finishOnboarding), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            continueButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 15),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func finishOnboarding() {
        if let skill = selectedItems.first?.title {
            preferencesManager.updateSkillLevel(skill)
        }
        
        UserDefaultsManager.shared.hasCompletedOnboarding = true
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        let tabBarController = sceneDelegate.createTabBarController()
        
        if let window = sceneDelegate.window {
            window.rootViewController = tabBarController
            UIView.transition(with: window,
                            duration: 0.5,
                            options: .transitionCrossDissolve,
                            animations: nil,
                            completion: nil)
        }
    }
}

extension SkillLevelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WTSelectableCell.reuseID,
            for: indexPath
        ) as! WTSelectableCell
        
        let item = items[indexPath.item]
        cell.set(item: item)
        
        if selectedItems.contains(item) {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Clear previous selection (only one skill level)
        selectedItems.removeAll()
        
        let item = items[indexPath.item]
        selectedItems.insert(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        selectedItems.remove(item)
    }
}
