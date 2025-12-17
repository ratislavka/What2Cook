//
//  OnboardingHelloVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit
import Lottie


class HelloVC: UIViewController {

    private let helloAnim = LottieAnimationView(name: "Hello-Anim")
    private let secondaryTextLabel = WTTitleLabel(textAlignment: .center, fontSize: 20)
    private let gotItButton = WTButton(backgroundColor: .systemOrange, title: "Got it!", cornerStyle: .rounded)
            

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.backgroundColor = .systemBackground

        configureHelloAnim()
        configureSecondaryLabel()
        configureGotItButton()
    }

    
    private func configureHelloAnim() {
        helloAnim.loopMode = .loop
        helloAnim.contentMode = .scaleAspectFit
        helloAnim.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(helloAnim)

        NSLayoutConstraint.activate([
            helloAnim.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloAnim.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            helloAnim.widthAnchor.constraint(equalToConstant: 260),
            helloAnim.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        helloAnim.play()
    }
    
    
    private func configureSecondaryLabel() {
        secondaryTextLabel.text =
        """
        What2Cook will help you answer
        the question, “What to cook today?”  
        """
        secondaryTextLabel.numberOfLines = 0
        secondaryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(secondaryTextLabel)
        
        NSLayoutConstraint.activate([
            secondaryTextLabel.topAnchor.constraint(equalTo: helloAnim.bottomAnchor, constant: -90),
            secondaryTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    private func configureGotItButton() {
        view.addSubview(gotItButton)
        
        gotItButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            gotItButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            gotItButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            gotItButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            gotItButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func nextVC() {
        let vc = DescriptionVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // Secondary label falls in 2.5 seconds after app opens
//        animateDropIn(secondaryTextLabel, delay: 2.5, offsetY: -50, duration: 1.2)
//
//        // Got it button falls in slightly later
//        animateDropIn(gotItButton, delay: 3.0, offsetY: -60, duration: 1.2)
//    }
//    
//    func animateDropIn(
//        _ view: UIView,
//        delay: TimeInterval = 2.5,      // start 2.5 seconds after app opens
//        offsetY: CGFloat = -40,
//        duration: TimeInterval = 1.2    // longer duration = slower fall
//    ) {
//        // Prepare initial state
//        view.alpha = 0
//        view.transform = CGAffineTransform(translationX: 0, y: offsetY)
//
//        // Animate to final state
//        UIView.animate(
//            withDuration: duration,
//            delay: delay,
//            usingSpringWithDamping: 0.6,       // lower damping = more bounce
//            initialSpringVelocity: 0.5,        // slower initial speed
//            options: .curveEaseOut,
//            animations: {
//                view.alpha = 1
//                view.transform = .identity
//            },
//            completion: nil
//        )
//    }
}
