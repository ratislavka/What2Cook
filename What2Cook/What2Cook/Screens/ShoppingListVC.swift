//
//  ShoppingListVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 17.12.2025.
//

import UIKit

class ShoppingListVC: UIViewController {
    
    private let shoppingManager = ShoppingListManager.shared
    private var items: [ShoppingItem] = []
    
    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureEmptyState()
        loadItems()
        setupObserver()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addItemTapped)
        )
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureEmptyState() {
        emptyLabel.text = "No items in shopping list"
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadItems() {
        items = shoppingManager.getAllItems()
        tableView.reloadData()
        emptyLabel.isHidden = !items.isEmpty
    }
    
    private func setupObserver() {
        shoppingManager.addObserver { [weak self] _ in
            self?.loadItems()
        }
    }
    
    @objc private func addItemTapped() {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Item name" }
        alert.addTextField { $0.placeholder = "Amount" }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let name = alert.textFields?[0].text, !name.isEmpty,
                  let amount = alert.textFields?[1].text, !amount.isEmpty else { return }
            
            self?.shoppingManager.addItem(name: name, amount: amount)
        })
        
        present(alert, animated: true)
    }
}

extension ShoppingListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = item.name
        config.secondaryText = item.amount
        cell.contentConfiguration = config
        
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        shoppingManager.toggleCheck(item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            shoppingManager.deleteItem(item)
        }
    }
}
