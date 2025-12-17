//
//  ProfileVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let shoppingButton = WTButton(backgroundColor: .systemGreen, title: "Shopping List", cornerStyle: .squared)
    private let startOnboarding = WTButton(backgroundColor: .systemOrange, title: "Change Preferences", cornerStyle: .squared)
    private let historyButton = WTButton(backgroundColor: .systemBlue, title: "Cooking History", cornerStyle: .squared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        configureChangePreferences()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.isTabBarHidden = false
    }
    

    private func configureChangePreferences() {
        view.addSubview(startOnboarding)
        startOnboarding.addTarget(self, action: #selector(onboardingVC), for: .touchUpInside)
        

        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
        view.addSubview(historyButton)
        

        shoppingButton.translatesAutoresizingMaskIntoConstraints = false
        shoppingButton.addTarget(self, action: #selector(showShoppingList), for: .touchUpInside)
        view.addSubview(shoppingButton)
        
        NSLayoutConstraint.activate([
            startOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            startOnboarding.heightAnchor.constraint(equalToConstant: 50),
            startOnboarding.widthAnchor.constraint(equalToConstant: 200),
            
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyButton.topAnchor.constraint(equalTo: startOnboarding.bottomAnchor, constant: 20),
            historyButton.heightAnchor.constraint(equalToConstant: 50),
            historyButton.widthAnchor.constraint(equalToConstant: 200),
            
            shoppingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shoppingButton.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 20),
            shoppingButton.heightAnchor.constraint(equalToConstant: 50),
            shoppingButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func onboardingVC() {
        let vc = CuisineTypeVC()
        tabBarController?.isTabBarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func showHistory() {
        let vc = CookingHistoryVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func showShoppingList() {
        let vc = ShoppingListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
