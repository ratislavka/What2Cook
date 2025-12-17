//
//  UIView+Shadow.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import UIKit

extension UIView {
    
    func applyCardStyle(
        cornerRadius: CGFloat = 12,
        shadowOpacity: Float = 0.1,
        shadowRadius: CGFloat = 8,
        shadowOffset: CGSize = CGSize(width: 0, height: 2)
    ) {
        backgroundColor = .systemBackground
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false
    }
}
