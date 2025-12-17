//
//  WTSelectableCell.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 09.12.2025.
//

import UIKit

class WTSelectableCell: UICollectionViewCell {
    
    static let reuseID = "SelectableCell"

//    private let iconView = UIImageView()
    private let iconView = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }

    func set(item: SelectableType) {
//        iconView.image = UIImage(named: item.icon)
        iconView.text = item.icon
        titleLabel.text = item.title
    }
    
    private func updateSelectionState() {
        if isSelected {
            contentView.layer.borderColor = UIColor.systemOrange.cgColor
            contentView.layer.borderWidth = 2
            contentView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.15)
        } else {
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.backgroundColor = .secondarySystemBackground
        }
    }

    private func configure() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .secondarySystemBackground

//        iconView.contentMode = .scaleAspectFit
        iconView.textAlignment = .center
        iconView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 40),
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}

