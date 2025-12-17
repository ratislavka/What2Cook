//
//  HelpTips.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 16.12.2025.
//

import UIKit


let tips = [
    CookingTip(icon: "🌡️", iconBg: UIColor.systemOrange.withAlphaComponent(0.15), title: "Temperature Control", description: "Let meat rest at room temperature 15-20 minutes before cooking for even results"),
    CookingTip(icon: "⏰", iconBg: UIColor.systemGreen.withAlphaComponent(0.15), title: "Timing is Everything", description: "Prep all ingredients before you start cooking - this is called \"mise en place\""),
    CookingTip(icon: "🔥", iconBg: UIColor.systemRed.withAlphaComponent(0.15), title: "Heat Management", description: "Preheat your pan before adding oil to prevent sticking and get better searing"),
    CookingTip(icon: "💧", iconBg: UIColor.systemBlue.withAlphaComponent(0.15), title: "Seasoning Layers", description: "Season at multiple stages while cooking, not just at the end")
]


let storageItems = [
    StorageItem(name: "Leafy Greens", location: "Fridge (crisper drawer)", duration: "3-5 days", durationColor: .systemOrange),
    StorageItem(name: "Fresh Meat", location: "Fridge (bottom shelf)", duration: "1-2 days", durationColor: .systemRed),
    StorageItem(name: "Hard Cheese", location: "Fridge", duration: "3-4 weeks", durationColor: .systemGreen),
    StorageItem(name: "Eggs", location: "Fridge", duration: "3-5 weeks", durationColor: .systemGreen),
    StorageItem(name: "Root Vegetables", location: "Cool, dark place", duration: "1-2 weeks", durationColor: .systemOrange),
    StorageItem(name: "Tomatoes", location: "Counter (not fridge)", duration: "3-5 days", durationColor: .systemOrange)
]


let conversions = [
    MeasurementConversion(from: "1 cup", to: "240 ml"),
    MeasurementConversion(from: "1 tablespoon", to: "15 ml"),
    MeasurementConversion(from: "1 teaspoon", to: "5 ml"),
    MeasurementConversion(from: "1 pound", to: "454 g"),
    MeasurementConversion(from: "1 ounce", to: "28 g")
]


let guides = [
    GuideItem(icon: "🔪", title: "Knife Skills Guide", iconColor: .systemOrange),
    GuideItem(icon: "🔥", title: "Cooking Methods Explained", iconColor: .systemGreen),
    GuideItem(icon: "📚", title: "Common Cooking FAQs", iconColor: .systemBlue)
]
