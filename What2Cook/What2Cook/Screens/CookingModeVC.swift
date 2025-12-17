//
//  CookingModeVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 10.12.2025.
//

import UIKit

class CookingModeVC: UIViewController {
    
    var recipe: Recipe?
    var servings: Int = 4
    
    private var currentStepIndex = 0
    private var timer: Timer?
    private var timeRemaining: Int = 0
    private var isTimerRunning = false
    
    private let progressBar = UIProgressView()
    private let stepCounterLabel = UILabel()
    private let stepNumberView = UIView()
    private let stepNumberLabel = UILabel()
    private let stepTextLabel = UILabel()
    
    private let timerContainerView = UIView()
    private let timerLabel = UILabel()
    private let timerButton = WTButton(backgroundColor: .systemBlue, title: "Set Timer", cornerStyle: .rounded)
    
    private let previousButton = WTButton(backgroundColor: .systemGray5, title: "Previous", cornerStyle: .rounded)
    private let nextButton = WTButton(backgroundColor: .systemOrange, title: "Next Step", cornerStyle: .rounded)
    private let finishButton = WTButton(backgroundColor: .systemGreen, title: "Finish Cooking", cornerStyle: .rounded)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UIApplication.shared.isIdleTimerDisabled = true
        
        navigationItem.title = recipe?.name ?? "Cooking"
        navigationItem.largeTitleDisplayMode = .never
        
        configureUI()
        updateStep()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        stopTimer()
    }
    
    private func configureUI() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = .systemOrange
        progressBar.trackTintColor = .systemGray5
        view.addSubview(progressBar)
        
        stepCounterLabel.font = .systemFont(ofSize: 15, weight: .medium)
        stepCounterLabel.textColor = .secondaryLabel
        stepCounterLabel.textAlignment = .center
        stepCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepCounterLabel)

        stepNumberView.backgroundColor = .systemOrange
        stepNumberView.layer.cornerRadius = 40
        stepNumberView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepNumberView)
        
        stepNumberLabel.font = .systemFont(ofSize: 32, weight: .bold)
        stepNumberLabel.textColor = .white
        stepNumberLabel.textAlignment = .center
        stepNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        stepNumberView.addSubview(stepNumberLabel)
        
        stepTextLabel.font = .systemFont(ofSize: 20, weight: .medium)
        stepTextLabel.textColor = .label
        stepTextLabel.numberOfLines = 0
        stepTextLabel.textAlignment = .left
        stepTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepTextLabel)
        
        timerContainerView.backgroundColor = .secondarySystemBackground
        timerContainerView.layer.cornerRadius = 12
        timerContainerView.translatesAutoresizingMaskIntoConstraints = false
        timerContainerView.isHidden = true  // Hidden by default
        view.addSubview(timerContainerView)
        
        timerLabel.text = "00:00"
        timerLabel.font = .monospacedDigitSystemFont(ofSize: 48, weight: .bold)
        timerLabel.textColor = .systemOrange
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerContainerView.addSubview(timerLabel)
        
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        timerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        timerButton.isHidden = true // !!!!!!!!! TIMER HIDDEN, UGLY
        view.addSubview(timerButton)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setTitleColor(.label, for: .normal)
        previousButton.addTarget(self, action: #selector(previousStepTapped), for: .touchUpInside)
        view.addSubview(previousButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextStepTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.addTarget(self, action: #selector(finishCookingTapped), for: .touchUpInside)
        finishButton.isHidden = true
        view.addSubview(finishButton)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 6),
            
            stepCounterLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 16),
            stepCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stepNumberView.topAnchor.constraint(equalTo: stepCounterLabel.bottomAnchor, constant: 32),
            stepNumberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepNumberView.widthAnchor.constraint(equalToConstant: 80),
            stepNumberView.heightAnchor.constraint(equalToConstant: 80),
            
            stepNumberLabel.centerXAnchor.constraint(equalTo: stepNumberView.centerXAnchor),
            stepNumberLabel.centerYAnchor.constraint(equalTo: stepNumberView.centerYAnchor),
            
            stepTextLabel.topAnchor.constraint(equalTo: stepNumberView.bottomAnchor, constant: 32),
            stepTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stepTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            timerContainerView.topAnchor.constraint(equalTo: stepTextLabel.bottomAnchor, constant: 24),
            timerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerContainerView.widthAnchor.constraint(equalToConstant: 200),
            timerContainerView.heightAnchor.constraint(equalToConstant: 100),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerContainerView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerContainerView.centerYAnchor),
            
            timerButton.topAnchor.constraint(equalTo: timerContainerView.bottomAnchor, constant: 16),
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.widthAnchor.constraint(equalToConstant: 150),
            timerButton.heightAnchor.constraint(equalToConstant: 44),
            
            previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            previousButton.heightAnchor.constraint(equalToConstant: 54),
            previousButton.widthAnchor.constraint(equalToConstant: 120),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 54),
            
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            finishButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func updateStep() {
        guard let recipe = recipe else { return }
        
        let totalSteps = recipe.steps.count
        let stepNumber = currentStepIndex + 1
        
        let progress = Float(stepNumber) / Float(totalSteps)
        progressBar.setProgress(progress, animated: true)
        
        stepCounterLabel.text = "Step \(stepNumber) of \(totalSteps)"
        stepNumberLabel.text = "\(stepNumber)"
        stepTextLabel.text = recipe.steps[currentStepIndex]
        
        previousButton.isEnabled = currentStepIndex > 0
        previousButton.alpha = currentStepIndex > 0 ? 1.0 : 0.5
        
        if currentStepIndex == totalSteps - 1 {
            nextButton.isHidden = true
            finishButton.isHidden = false
        } else {
            nextButton.isHidden = false
            finishButton.isHidden = true
        }
        
        // Reset timer for new step
        stopTimer()
        timerContainerView.isHidden = true
        timerButton.setTitle("Set Timer", for: .normal)
    }
    
    @objc private func timerButtonTapped() {
        if isTimerRunning {
            stopTimer()
        } else {
            showTimerPicker()
        }
    }
    
    private func showTimerPicker() {
        let alert = UIAlertController(title: "Set Timer", message: "Enter minutes", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Minutes"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Start", style: .default) { [weak self] _ in
            guard let minutesText = alert.textFields?.first?.text,
                  let minutes = Int(minutesText),
                  minutes > 0 else { return }
            
            self?.startTimer(minutes: minutes)
        })
        
        present(alert, animated: true)
    }
    
    private func startTimer(minutes: Int) {
        timeRemaining = minutes * 60
        isTimerRunning = true
        timerContainerView.isHidden = false
        timerButton.setTitle("Stop Timer", for: .normal)
        timerButton.backgroundColor = .systemRed
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
        
        updateTimerDisplay()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        timeRemaining = 0
        timerButton.setTitle("Set Timer", for: .normal)
        timerButton.backgroundColor = .systemBlue
    }
    
    private func updateTimer() {
        timeRemaining -= 1
        
        if timeRemaining <= 0 {
            stopTimer()
            timerFinished()
        } else {
            updateTimerDisplay()
        }
    }
    
    private func updateTimerDisplay() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        // Change color when time is low
        if timeRemaining <= 60 {
            timerLabel.textColor = .systemRed
        } else {
            timerLabel.textColor = .systemOrange
        }
    }
    
    private func timerFinished() {
        // Vibrate
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let alert = UIAlertController(title: "⏰ Timer Finished!", message: "Time to move to the next step", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func previousStepTapped() {
        guard currentStepIndex > 0 else { return }
        currentStepIndex -= 1
        updateStep()
    }
    
    @objc private func nextStepTapped() {
        guard let recipe = recipe else { return }
        guard currentStepIndex < recipe.steps.count - 1 else { return }
        
        currentStepIndex += 1
        updateStep()
    }
    
    @objc private func finishCookingTapped() {
        CookingHistoryManager.shared.addCookedRecipe(recipe!, servings: servings)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
