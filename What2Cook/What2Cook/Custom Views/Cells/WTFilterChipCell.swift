//
//  WTFilterChipCell.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 10.12.2025.
//

import UIKit

class WTFilterChipCell: UICollectionViewCell {
    
    static let reuseID = "WTFilterChipCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String, isSelected: Bool) {
        label.text = text
        
        if isSelected {
            contentView.backgroundColor = .systemOrange
            label.textColor = .white
        } else {
            contentView.backgroundColor = .systemGray6
            label.textColor = .label
        }
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
