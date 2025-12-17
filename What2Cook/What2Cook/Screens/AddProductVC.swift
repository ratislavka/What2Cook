//
//  AddProductVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class AddProductVC: UIViewController {
    
    weak var delegate: AddProductDelegate?
    var productTemplate: ProductTemplate?
    var existingItem: FridgeItem?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let productImageView = UIImageView()
    private let productNameLabel = UILabel()
    private let categoryLabel = UILabel()
    
    private let quantitySectionLabel = UILabel()
    private let quantityContainerView = UIView()
    private let decreaseButton = UIButton()
    private let quantityTextField = UITextField()
    private let increaseButton = UIButton()
    
    private let expirationSectionLabel = UILabel()
    private let expirationContainerView = UIView()
    private let calendarIcon = UIImageView()
    private let expirationDateLabel = UILabel()
    private let datePicker = UIDatePicker()
    
    private let daysInfoStack = UIStackView()
    
    private let storageSectionLabel = UILabel()
    private let storageButtonsStack = UIStackView()
    private var storageButtons: [UIButton] = []
    private var selectedStorage: StorageLocation = .fridge
    
//    private let addButton = WTButton(backgroundColor: .systemOrange, title: "Add to Fridge", cornerStyle: .rounded)
    private let deleteButton = WTButton(backgroundColor: .systemRed, title: "Delete", cornerStyle: .rounded)
    
    private var currentQuantity = 1
    private var selectedDate = Date().addingTimeInterval(86400 * 7) // 7 days from now
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = existingItem == nil ? "Add to Fridge" : "Edit Product"
        
        configureNavigationBar()
        configureScrollView()
        configureProductHeader()
        configureQuantitySection()
        configureExpirationSection()
        configureStorageSection()
        configureButtons()
        
        populateData()
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancelButton
 
        if existingItem != nil {
            let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(addButtonTapped))
            navigationItem.rightBarButtonItem = saveButton
        } else {
            let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addButtonTapped))
            navigationItem.rightBarButtonItem = addButton
        }
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureProductHeader() {
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 12
        productImageView.backgroundColor = .secondarySystemBackground
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
        
        productNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productNameLabel)
        
        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.textColor = .secondaryLabel
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 12),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            categoryLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16)
        ])
    }
    
    private func configureQuantitySection() {
        quantitySectionLabel.text = "Quantity"
        quantitySectionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        quantitySectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantitySectionLabel)
        
        quantityContainerView.backgroundColor = .secondarySystemBackground
        quantityContainerView.layer.cornerRadius = 12
        quantityContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantityContainerView)
        
        decreaseButton.setImage(UIImage(systemName: "minus"), for: .normal)
        decreaseButton.tintColor = .label
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        quantityContainerView.addSubview(decreaseButton)
        
        quantityTextField.text = "1"
        quantityTextField.textAlignment = .center
        quantityTextField.font = .systemFont(ofSize: 20, weight: .semibold)
        quantityTextField.keyboardType = .numberPad
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        quantityContainerView.addSubview(quantityTextField)
        
        increaseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        increaseButton.tintColor = .label
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        quantityContainerView.addSubview(increaseButton)
        
        NSLayoutConstraint.activate([
            quantitySectionLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 32),
            quantitySectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            quantityContainerView.topAnchor.constraint(equalTo: quantitySectionLabel.bottomAnchor, constant: 12),
            quantityContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quantityContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quantityContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            decreaseButton.leadingAnchor.constraint(equalTo: quantityContainerView.leadingAnchor, constant: 20),
            decreaseButton.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            decreaseButton.widthAnchor.constraint(equalToConstant: 40),
            decreaseButton.heightAnchor.constraint(equalToConstant: 40),
            
            quantityTextField.centerXAnchor.constraint(equalTo: quantityContainerView.centerXAnchor),
            quantityTextField.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            quantityTextField.widthAnchor.constraint(equalToConstant: 100),
            
            increaseButton.trailingAnchor.constraint(equalTo: quantityContainerView.trailingAnchor, constant: -20),
            increaseButton.centerYAnchor.constraint(equalTo: quantityContainerView.centerYAnchor),
            increaseButton.widthAnchor.constraint(equalToConstant: 40),
            increaseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureExpirationSection() {
        expirationSectionLabel.text = "Expiration Date"
        expirationSectionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        expirationSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expirationSectionLabel)
        
        expirationContainerView.backgroundColor = .secondarySystemBackground
        expirationContainerView.layer.cornerRadius = 12
        expirationContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expirationContainerView)
        
        calendarIcon.image = UIImage(systemName: "calendar")
        calendarIcon.tintColor = .systemOrange
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        expirationContainerView.addSubview(calendarIcon)
        
        expirationDateLabel.font = .systemFont(ofSize: 16)
        expirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationContainerView.addSubview(expirationDateLabel)
        
        datePicker.tintColor = .systemOrange
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        contentView.addSubview(datePicker)
        
        daysInfoStack.axis = .horizontal
        daysInfoStack.distribution = .equalSpacing
        daysInfoStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(daysInfoStack)
        
        let days = [(1, "1 day"), (2, "2 days"), (7, "1 week"), (30, "30 days")]
        for (value, label) in days {
            let button = createDayButton(days: value, label: label)
            daysInfoStack.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            expirationSectionLabel.topAnchor.constraint(equalTo: quantityContainerView.bottomAnchor, constant: 24),
            expirationSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            expirationContainerView.topAnchor.constraint(equalTo: expirationSectionLabel.bottomAnchor, constant: 12),
            expirationContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            expirationContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            expirationContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            calendarIcon.leadingAnchor.constraint(equalTo: expirationContainerView.leadingAnchor, constant: 16),
            calendarIcon.centerYAnchor.constraint(equalTo: expirationContainerView.centerYAnchor),
            calendarIcon.widthAnchor.constraint(equalToConstant: 24),
            calendarIcon.heightAnchor.constraint(equalToConstant: 24),
            
            expirationDateLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 12),
            expirationDateLabel.centerYAnchor.constraint(equalTo: expirationContainerView.centerYAnchor),
            
            daysInfoStack.topAnchor.constraint(equalTo: expirationContainerView.bottomAnchor, constant: 12),
            daysInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            daysInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            datePicker.topAnchor.constraint(equalTo: daysInfoStack.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        updateExpirationLabel()
    }
    
    private func configureStorageSection() {
        storageSectionLabel.text = "Storage Location"
        storageSectionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        storageSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storageSectionLabel)
        
        storageButtonsStack.axis = .horizontal
        storageButtonsStack.spacing = 12
        storageButtonsStack.distribution = .fillEqually
        storageButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storageButtonsStack)
        
        for location in StorageLocation.allCases {
            let button = createStorageButton(location: location)
            storageButtons.append(button)
            storageButtonsStack.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            storageSectionLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 24),
            storageSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            storageButtonsStack.topAnchor.constraint(equalTo: storageSectionLabel.bottomAnchor, constant: 12),
            storageButtonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            storageButtonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            storageButtonsStack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        updateStorageButtons()
    }
    
    private func configureButtons() {
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        contentView.addSubview(addButton)
//        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isHidden = existingItem == nil
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
//            addButton.topAnchor.constraint(equalTo: storageButtonsStack.bottomAnchor, constant: 32),
//            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            addButton.heightAnchor.constraint(equalToConstant: 54),
//            
//            deleteButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 12),
            deleteButton.topAnchor.constraint(equalTo: storageButtonsStack.bottomAnchor, constant: 12),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 54),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func createDayButton(days: Int, label: String) -> UIButton {
        let button = UIButton()
        button.setTitle(label, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 8
        button.tag = days
        button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func createStorageButton(location: StorageLocation) -> UIButton {
        let button = UIButton()
        button.setTitle(location.rawValue, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 12
        button.tag = StorageLocation.allCases.firstIndex(of: location) ?? 0
        button.addTarget(self, action: #selector(storageButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func populateData() {
        if let item = existingItem {
            productImageView.image = UIImage(named: item.image)
            productNameLabel.text = item.name
            categoryLabel.text = "Fruit"
            currentQuantity = Int(item.quantity.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 1
            quantityTextField.text = "\(currentQuantity)"
            selectedDate = item.expirationDate
            datePicker.date = selectedDate
            selectedStorage = item.storageLocation
//            addButton.setTitle("Update Product", for: .normal)
        } else if let product = productTemplate {
            productImageView.image = UIImage(named: product.image)
            productNameLabel.text = product.name
            categoryLabel.text = product.category.displayName

        }
        
        updateExpirationLabel()
        updateStorageButtons()
    }
    
    private func updateExpirationLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        expirationDateLabel.text = formatter.string(from: selectedDate)
    }
    
    private func updateStorageButtons() {
        for (index, button) in storageButtons.enumerated() {
            if index == StorageLocation.allCases.firstIndex(of: selectedStorage) {
                button.backgroundColor = .systemOrange
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemBackground
                button.setTitleColor(.label, for: .normal)
            }
        }
    }
    
    @objc private func decreaseQuantity() {
        if currentQuantity > 1 {
            currentQuantity -= 1
            quantityTextField.text = "\(currentQuantity)"
        }
    }
    
    @objc private func increaseQuantity() {
        currentQuantity += 1
        quantityTextField.text = "\(currentQuantity)"
    }
    
    @objc private func dateChanged() {
        selectedDate = datePicker.date
        updateExpirationLabel()
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        let days = sender.tag
        selectedDate = Date().addingTimeInterval(Double(days) * 86400)
        datePicker.date = selectedDate
        updateExpirationLabel()
    }
    
    @objc private func storageButtonTapped(_ sender: UIButton) {
        selectedStorage = StorageLocation.allCases[sender.tag]
        updateStorageButtons()
    }
    
    @objc private func addButtonTapped() {
        let daysUntilExpiry = Calendar.current.dateComponents([.day], from: Date(), to: selectedDate).day ?? 0
        let expiryStatus: ExpiryStatus = daysUntilExpiry <= 2 ? .expired : (daysUntilExpiry <= 5 ? .expiringSoon : .fresh)
        
        let item = FridgeItem(
            name: productNameLabel.text ?? "",
            quantity: "\(currentQuantity) pcs",
            image: productTemplate?.image ?? existingItem?.image ?? "",
            daysUntilExpiry: daysUntilExpiry,
            expiryStatus: expiryStatus,
            storageLocation: selectedStorage,
            expirationDate: selectedDate
        )
        
        if existingItem != nil {
            delegate?.didUpdateProduct(item)
        } else {
            delegate?.didAddProduct(item)
        }
        
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        guard let item = existingItem else { return }
        
        let alert = UIAlertController(title: "Delete Product", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.delegate?.didDeleteProduct(item)
            self?.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
}
