//
//  CookingHistoryVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 17.12.2025.
//

import UIKit

class CookingHistoryVC: UIViewController {
    
    private let historyManager = CookingHistoryManager.shared
    private var history: [CookedRecipe] = []
    
    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cooking History"
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHistory()
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
        emptyLabel.text = "No cooking history yet"
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
    
    private func loadHistory() {
        history = historyManager.getAllHistory()
        tableView.reloadData()
        emptyLabel.isHidden = !history.isEmpty
    }
}

extension CookingHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = history[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = item.recipeName
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        config.secondaryText = "Cooked on \(formatter.string(from: item.dateCool))"
        
        cell.contentConfiguration = config
        
        return cell
    }
}
