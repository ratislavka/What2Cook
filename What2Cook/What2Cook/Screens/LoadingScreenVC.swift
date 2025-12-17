//
//  LoadingScreenVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit
import Lottie

class LoadingScreenVC: UIViewController {

    private let loadingAnim = LottieAnimationView(name: "Food_Loading-Anim")
    private let loadingLabel = WTBodyLabel(textalignment: .center)
    private let hintLabel = WTTitleLabel(textAlignment: .center, fontSize: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
         
        configureLoadingAnim()
        configureLoadingLabel()
        configureHintLabel()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.goToNextScreen()
        }
    }
    
    private func goToNextScreen() {
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

    
    private func configureLoadingAnim() {
        view.addSubview(loadingAnim)
        
        loadingAnim.loopMode = .loop
        loadingAnim.contentMode = .scaleAspectFit
        loadingAnim.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingAnim.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnim.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingAnim.widthAnchor.constraint(equalToConstant: 150),
            loadingAnim.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        loadingAnim.play()
    }
    
    
    private func configureLoadingLabel() {
        view.addSubview(loadingLabel)
        
        loadingLabel.text = "Prepping you meals"
        
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: loadingAnim.bottomAnchor, constant: 10),
            loadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
    
    
    private func configureHintLabel() {
        view.addSubview(hintLabel)
        
        hintLabel.text = "Don’t worry about missing ingredients — we’ll suggest substitutes!"
        hintLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 70),
            hintLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hintLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
