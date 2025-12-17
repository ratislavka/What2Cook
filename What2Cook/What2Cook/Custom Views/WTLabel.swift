//
//  WTLabel.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

//import UIKit
//
//final class WTLabel: UILabel {
//
//    init(style: LabelStyle, textAlignment: NSTextAlignment = .left) {
//        super.init(frame: .zero)
//        self.textAlignment = textAlignment
//        apply(style)
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func apply(_ style: LabelStyle) {
//        switch style {
//        case .title:
//            font = .systemFont(ofSize: 16, weight: .medium)
//            textColor = .label
//
//        case .body:
//            font = .systemFont(ofSize: 14)
//            textColor = .label
//
//        case .secondary:
//            font = .systemFont(ofSize: 13)
//            textColor = .secondaryLabel
//
//        case .metadata:
//            font = .systemFont(ofSize: 14, weight: .medium)
//            textColor = .secondaryLabel
//        }
//
//        adjustsFontSizeToFitWidth = true
//        minimumScaleFactor = 0.8
//        lineBreakMode = .byTruncatingTail
//    }
//}
