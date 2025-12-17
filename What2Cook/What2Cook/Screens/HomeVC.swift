//
//  HomeVC.swift
//  What2Cook
//
//  Created by Ratislav Ovchinnikov on 07.12.2025.
//

import UIKit

class HomeVC: UIViewController {
    
    private let greetingView = UIView()
    private let greetingTitleLabel = WTTitleLabel(textAlignment: .left, fontSize: 20)
    private let greetingSubtitleLabel = WTBodyLabel(textalignment: .left)
    private let searchBar = UISearchBar()
    private var filterCollectionView: UICollectionView! 
    private let recipeTableView = UITableView()
    
    private let filters = ["< 30 min", "Easy", "Vegan", "Italian"]
//    private var selectedFilters = Set<String>()
    private let recipeService = RecipeService.shared
    private var allRecipes: [Recipe] = recipes
    private var filteredRecipes: [Recipe] = []
    private var displayedRecipes: [Recipe] = []
    private var selectedFilters = Set<String>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        filteredRecipes = allRecipes
        
        configureGreetingView()
        configureFilterCollectionView()
        configureSearchBar()
        configureRecipeTableView()
        updateRecipes()
    }
    
    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateRecipes()
    }
    
    private func updateRecipes() {
        var tempRecipes = allRecipes
        
        // FIRST: Apply search filter if exists
        if let searchText = searchBar.text, !searchText.isEmpty {
            let query = searchText.lowercased()
            tempRecipes = tempRecipes.filter { recipe in
                recipe.name.lowercased().contains(query) ||
                recipe.cuisine.lowercased().contains(query) ||
                recipe.difficulty.lowercased().contains(query)
            }
        }
        
        // SECOND: Apply selected filters using RecipeService
        if !selectedFilters.isEmpty {
            let filterArray = Array(selectedFilters)
            tempRecipes = recipeService.applyFilters(filterArray, to: tempRecipes)
        }
        
        // THIRD: Sort the filtered results
        displayedRecipes = recipeService.getRecommendedRecipes(
            from: tempRecipes,
            applyingFilters: []
        )
        
        recipeTableView.reloadData()
    }

    
    private func configureSearchBar() {
        searchBar.placeholder = "Search recipes..."
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureGreetingView() {
        greetingView.translatesAutoresizingMaskIntoConstraints = false
        greetingView.backgroundColor = .systemOrange
        greetingView.layer.cornerRadius = 16
        
        
        view.addSubview(greetingView)
        
        NSLayoutConstraint.activate([
            greetingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            greetingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            greetingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            greetingView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        configureGreetingTitleLabel()
        configureGreetingSubtitleLabel()
    }
    
    private func configureGreetingTitleLabel() {
        greetingTitleLabel.text = "Good day!"
        greetingTitleLabel.textColor = .white
        
        greetingView.addSubview(greetingTitleLabel)
        
        NSLayoutConstraint.activate([
            greetingTitleLabel.topAnchor.constraint(equalTo: greetingView.topAnchor, constant: 20),
            greetingTitleLabel.leadingAnchor.constraint(equalTo: greetingView.leadingAnchor, constant: 20),
            greetingTitleLabel.trailingAnchor.constraint(equalTo: greetingView.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureGreetingSubtitleLabel() {
        greetingSubtitleLabel.text = "What shall we cook today?"
        greetingSubtitleLabel.textColor = .white
        
        greetingView.addSubview(greetingSubtitleLabel)
        
        NSLayoutConstraint.activate([
            greetingSubtitleLabel.topAnchor.constraint(equalTo: greetingTitleLabel.bottomAnchor, constant: 8),
            greetingSubtitleLabel.leadingAnchor.constraint(equalTo: greetingView.leadingAnchor, constant: 20),
            greetingSubtitleLabel.trailingAnchor.constraint(equalTo: greetingView.trailingAnchor, constant: -20)
        ])
    }
    
    
    private func configureFilterCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        view.addSubview(filterCollectionView)
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: greetingView.bottomAnchor, constant: 16),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        filterCollectionView.register(WTFilterChipCell.self, forCellWithReuseIdentifier: WTFilterChipCell.reuseID)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    
    private func configureRecipeTableView() {
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.backgroundColor = .clear
        recipeTableView.separatorStyle = .none
        recipeTableView.rowHeight = 290
        recipeTableView.keyboardDismissMode = .onDrag 
        
        view.addSubview(recipeTableView)
        
        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        recipeTableView.register(WTRecipeCardCell.self, forCellReuseIdentifier: WTRecipeCardCell.reuseID)
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
    
}



extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WTRecipeCardCell.reuseID, for: indexPath) as! WTRecipeCardCell
        
        let recipe = displayedRecipes[indexPath.row]
        
        let matchResult = recipeService.getMatchResult(for: recipe)
        
        cell.configure(with: recipe, availabilityPercentage: matchResult.availabilityPercentage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipeDetailsVC = RecipeDetailsVC()
        recipeDetailsVC.recipe = displayedRecipes[indexPath.row]
        navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
}



extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTFilterChipCell.reuseID, for: indexPath) as! WTFilterChipCell
        let filter = filters[indexPath.item]
        cell.configure(with: filter, isSelected: selectedFilters.contains(filter))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters[indexPath.item]
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
        collectionView.reloadItems(at: [indexPath])
        updateRecipes() 
    }
}



extension HomeVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateRecipes()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
