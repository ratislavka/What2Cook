//
//  FridgeVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class FridgeVC: UIViewController {
    
    private let titleLabel = WTTitleLabel(textAlignment: .left, fontSize: 32)
    private let itemCountLabel = WTBodyLabel(textalignment: .left)
    private let addButton = UIButton()
    private var collectionView: UICollectionView!
    
    private let fridgeManager = FridgeManager.shared
    private var fridgeItems: [FridgeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        configureTitleSection()
        configureAddButton()
        configureCollectionView()
        loadFridgeItems()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateItemCount()
    }
    
    private func loadFridgeItems() {
        fridgeItems = fridgeManager.getAllItems().sorted { item1, item2 in
            item1.daysUntilExpiry < item2.daysUntilExpiry
        }
        collectionView.reloadData()
        updateItemCount()
    }
    
    private func setupObserver() {
        fridgeManager.addObserver { [weak self] items in
            self?.fridgeItems = items.sorted { $0.daysUntilExpiry < $1.daysUntilExpiry }
            self?.collectionView.reloadData()
            self?.updateItemCount()
        }
    }
    
    private func configureTitleSection() {
        titleLabel.text = "My Fridge"
        view.addSubview(titleLabel)
        
        itemCountLabel.textColor = .secondaryLabel
        view.addSubview(itemCountLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            
            itemCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            itemCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func configureAddButton() {
        addButton.backgroundColor = .systemOrange
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 25
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: itemCountLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.register(FridgeItemCell.self, forCellWithReuseIdentifier: FridgeItemCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateItemCount() {
        itemCountLabel.text = "\(fridgeItems.count) items stored"
    }
    
    @objc private func addButtonTapped() {
        let selectProductVC = SelectProductVC()
        selectProductVC.delegate = self
        let navController = UINavigationController(rootViewController: selectProductVC)
        navController.modalPresentationStyle = .pageSheet
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navController, animated: true)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension FridgeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fridgeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FridgeItemCell.reuseID, for: indexPath) as! FridgeItemCell
        cell.configure(with: fridgeItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20 + 12 + 20
        let availableWidth = view.bounds.width - padding
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = fridgeItems[indexPath.item]
        let addProductVC = AddProductVC()
        addProductVC.existingItem = item
        addProductVC.delegate = self
        
        let navController = UINavigationController(rootViewController: addProductVC)
        navController.modalPresentationStyle = .pageSheet
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navController, animated: true)
    }
}

// MARK: - SelectProductDelegate
extension FridgeVC: SelectProductDelegate {
    func didSelectProduct(_ product: ProductTemplate) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            let addProductVC = AddProductVC()
            addProductVC.productTemplate = product
            addProductVC.delegate = self
            
            let navController = UINavigationController(rootViewController: addProductVC)
            navController.modalPresentationStyle = .pageSheet
            
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
            }
            
            self.present(navController, animated: true)
        }
    }
}

// MARK: - AddProductDelegate
extension FridgeVC: AddProductDelegate {
    func didAddProduct(_ item: FridgeItem) {
        fridgeManager.addItem(item)
    }
    
    func didUpdateProduct(_ item: FridgeItem) {
        fridgeManager.updateItem(item)
    }
    
    func didDeleteProduct(_ item: FridgeItem) {
        fridgeManager.deleteItem(item)  
    }
}



// MARK: - Models
struct FridgeItem: Identifiable {
    let id = UUID()
    let name: String
    let quantity: String
    let image: String
    let daysUntilExpiry: Int
    let expiryStatus: ExpiryStatus
    let storageLocation: StorageLocation
    let expirationDate: Date
    
    init(name: String, quantity: String, image: String, daysUntilExpiry: Int, expiryStatus: ExpiryStatus, storageLocation: StorageLocation = .fridge, expirationDate: Date = Date().addingTimeInterval(86400 * 7)) {
        self.name = name
        self.quantity = quantity
        self.image = image
        self.daysUntilExpiry = daysUntilExpiry
        self.expiryStatus = expiryStatus
        self.storageLocation = storageLocation
        self.expirationDate = expirationDate
    }
}

enum ExpiryStatus {
    case fresh
    case expiringSoon
    case expired
    
    var color: UIColor {
        switch self {
        case .fresh: return .systemGreen
        case .expiringSoon: return .systemOrange
        case .expired: return .systemRed
        }
    }
}

extension ExpiryStatus: Codable {
    var rawValue: String {
        switch self {
        case .fresh: return "fresh"
        case .expiringSoon: return "expiringSoon"
        case .expired: return "expired"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "fresh": self = .fresh
        case "expiringSoon": self = .expiringSoon
        case "expired": self = .expired
        default: return nil
        }
    }
}

enum StorageLocation: String, CaseIterable {
    case fridge = "Fridge"
    case freezer = "Freezer"
    case pantry = "Pantry"
}

// MARK: - Delegates
protocol SelectProductDelegate: AnyObject {
    func didSelectProduct(_ product: ProductTemplate)
}

protocol AddProductDelegate: AnyObject {
    func didAddProduct(_ item: FridgeItem)
    func didUpdateProduct(_ item: FridgeItem)
    func didDeleteProduct(_ item: FridgeItem)
}
