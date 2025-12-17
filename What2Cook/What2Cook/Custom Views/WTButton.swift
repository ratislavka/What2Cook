//
//  WTButton.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//


import UIKit


class WTButton: UIButton {
    
    private var cornerStyle: CornerStyle = .squared

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
     }
    
    init(backgroundColor: UIColor, title: String, cornerStyle: CornerStyle){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.cornerStyle = cornerStyle
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        switch cornerStyle {
        case .rounded:
            layer.cornerRadius = 25
        case .squared:
            layer.cornerRadius = 10
        }
            
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false

    }

}

enum CornerStyle {
    case rounded
    case squared
}
