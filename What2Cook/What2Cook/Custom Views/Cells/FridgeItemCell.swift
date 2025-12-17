//
//  FridgeItemCell.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 10.12.2025.
//

import UIKit

class FridgeItemCell: UICollectionViewCell {
    
    static let reuseID = "FridgeItemCell"
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let expiryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: FridgeItem) {
        imageView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        quantityLabel.text = item.quantity
        expiryLabel.text = "Expires in \(item.daysUntilExpiry) days"
        expiryLabel.textColor = item.expiryStatus.color
    }
    
    private func configure() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 6
        containerView.layer.shadowOpacity = 0.1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        let badge = UILabel()
        badge.text = "Fresh"
        badge.font = .systemFont(ofSize: 11, weight: .semibold)
        badge.textColor = .white
        badge.backgroundColor = .systemGreen
        badge.textAlignment = .center
        badge.layer.cornerRadius = 8
        badge.clipsToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(badge)
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        
        quantityLabel.font = .systemFont(ofSize: 14)
        quantityLabel.textColor = .label
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(quantityLabel)
        
        expiryLabel.font = .systemFont(ofSize: 12)
        expiryLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(expiryLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            badge.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            badge.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            badge.widthAnchor.constraint(equalToConstant: 50),
            badge.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            quantityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            expiryLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 4),
            expiryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            expiryLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
