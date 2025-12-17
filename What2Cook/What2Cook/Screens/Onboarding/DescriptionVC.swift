//
//  DescriptionVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit
import Lottie

class DescriptionVC: UIViewController {

    let foodPrepAnim = LottieAnimationView(name: "Food_prep-Anim")
    let descriptionLabel = WTTitleLabel(textAlignment: .center, fontSize: 25)
    let ingredientsAnim = LottieAnimationView(name: "Ingredients-Anim")
    let ingredientsLabel = WTTitleLabel(textAlignment: .center, fontSize: 20)
    let timeAnim = LottieAnimationView(name: "Clock_loop-Anim")
    let timeLabel = WTTitleLabel(textAlignment: .center, fontSize: 20)
    let preferencesAnim = LottieAnimationView(name: "Preferences_Toggle-Anim")
    let preferencesLabel = WTTitleLabel(textAlignment: .center, fontSize: 20)
    let coolButton = WTButton(backgroundColor: .orange, title: "Cool!", cornerStyle: .rounded)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureFoodPrepAnim()
        configureDescriptionLabel()
        configureFeatureStacks()
        
        configureCoolButton()
    }

    
    private func configureFoodPrepAnim() {
        foodPrepAnim.loopMode = .loop
        foodPrepAnim.contentMode = .scaleAspectFit
        foodPrepAnim.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(foodPrepAnim)

        NSLayoutConstraint.activate([
            foodPrepAnim.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            foodPrepAnim.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            foodPrepAnim.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        ])
        
        foodPrepAnim.play()
    }
    
    
    private func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.text = "This app helps you decide what to cook based on your"
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: foodPrepAnim.bottomAnchor, constant: -100),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureFeatureStacks() {
        let size: CGFloat = 100

        [ingredientsAnim, timeAnim, preferencesAnim].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.loopMode = .loop
            $0.contentMode = .scaleAspectFit
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: size),
                $0.heightAnchor.constraint(equalToConstant: size)
            ])
            $0.play()
        }
        
        ingredientsLabel.text = "Ingredients"
        timeLabel.text = "Time"
        preferencesLabel.text = "Preferences"
        
        let ingredientsStack = UIStackView(arrangedSubviews: [ingredientsAnim, ingredientsLabel])
        let timeStack        = UIStackView(arrangedSubviews: [timeAnim, timeLabel])
        let preferencesStack = UIStackView(arrangedSubviews: [preferencesAnim, preferencesLabel])

        [ingredientsStack, timeStack, preferencesStack].forEach {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 8
        }

        let featureStack = UIStackView(arrangedSubviews: [
            ingredientsStack, timeStack, preferencesStack
        ])
        featureStack.axis = .horizontal
        featureStack.alignment = .top
        featureStack.distribution = .equalSpacing
        featureStack.spacing = 20
        featureStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(featureStack)

        NSLayoutConstraint.activate([
            featureStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            featureStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            featureStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    private func configureCoolButton() {
        view.addSubview(coolButton)
        
        coolButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            coolButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            coolButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            coolButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            coolButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func nextVC() {
        let vc = CuisineTypeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
