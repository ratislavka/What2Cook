//
//  StepIndicatorView.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 09.12.2025.
//
import UIKit

class StepIndicatorView: UIView {

    private var step: Int = 1
    private var totalSteps: Int = 3

    private let stepLabel = UILabel()
    private var indicators: [UIView] = []
    private let stack = UIStackView()

    init(step: Int, totalSteps: Int) {
        super.init(frame: .zero)
        self.step = step
        self.totalSteps = totalSteps
        setup()
        updateIndicators()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Stack
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        // MARK: - Step label
        stepLabel.font = .systemFont(ofSize: 14)
        stepLabel.textColor = .gray
        stepLabel.textAlignment = .center
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stepLabel)

        NSLayoutConstraint.activate([
            stepLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 6),
            stepLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        for _ in 0..<totalSteps {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(v)
            indicators.append(v)

            NSLayoutConstraint.activate([
                v.heightAnchor.constraint(equalToConstant: 6)
            ])
        }
    }

    private func updateIndicators() {
        stepLabel.text = "Step \(step) of \(totalSteps)"

        for (index, view) in indicators.enumerated() {

            if index == step - 1 {
                // Active step (yellow bar)
                view.backgroundColor = .systemYellow
                view.layer.cornerRadius = 3

                NSLayoutConstraint.deactivate(view.constraints)
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: 40),
                    view.heightAnchor.constraint(equalToConstant: 6)
                ])

            } else {
                // Inactive dots
                view.backgroundColor = .systemGray4
                view.layer.cornerRadius = 3

                NSLayoutConstraint.deactivate(view.constraints)
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: 6),
                    view.heightAnchor.constraint(equalToConstant: 6)
                ])
            }
        }
    }

    func setStep(_ newStep: Int) {
        self.step = newStep
        updateIndicators()
    }
}
