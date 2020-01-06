//
//  StoreViewController.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    var sharedStoreView = SharedStoreView()
    private var menuArray: [String] = []
    var selectedStore: Store?
    var dataManager = DataManager()
    let secondVC = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view = sharedStoreView
        loadFavoriteStores()
        
        sharedStoreView.tableView.delegate = self
        sharedStoreView.tableView.dataSource = self
        
        sharedStoreView.addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesButtonTapped), for: .touchUpInside)
        
        guard let selectedStore = selectedStore else {return}
        let urlString = selectedStore.image
        guard let url = URL(string: urlString) else {return}
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.sharedStoreView.storeImage.image = image
            }
        } catch {
            let image = UIImage(named: "FoodToDoorPlaceHolder")
            DispatchQueue.main.async {
                self.sharedStoreView.storeImage.image = image
            }
        }
        
        guard let deliveryTime = selectedStore.deliveryTime, let deliveryFee = selectedStore.deliveryFee else {return}
        guard let tabBarController = self.tabBarController else {return}
        
        NetworkManager.shared.fetchMenu(with: selectedStore.id) { result in
            
            switch result {
            case .success(let menus):
                self.menuArray = menus
                DispatchQueue.main.async {
                    self.sharedStoreView.tableView.reloadData()
                }
            case .failure(let error):
                self.presentFTDAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
        
        DispatchQueue.main.async {
            self.navigationItem.title = selectedStore.business.name
            self.sharedStoreView.deliveryLabel.text = selectedStore.deliveryFee == 0 ? "Free Delivery in \(deliveryTime) min" : "Delivery for $\(deliveryFee) in \(deliveryTime) min"
            
            if deliveryTime == 0{
                self.sharedStoreView.deliveryLabel.text = "Free Delivery"
            }
            
            self.sharedStoreView.addToFavoritesButton.configure(for: tabBarController, store: selectedStore)
        }
    }
    
    func loadFavoriteStores() {
        guard let navController = tabBarController?.viewControllers?[secondVC] as? UINavigationController else {return}
        guard let favoriteVC = navController.viewControllers.first as? FavoritesViewController else {return}
        
        do {
            try favoriteVC.dataManager.loadFavorites()
        } catch {
            DispatchQueue.main.async {
                self.presentFTDAlertOnMainThread(title: "Something went wrong", message: FTDError.unableToLoadFavorites.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc func addToFavoritesButtonTapped() {
        sharedStoreView.addToFavoritesButton.favoritedUISetup()
        
        guard let navController = tabBarController?.viewControllers?[secondVC] as? UINavigationController else {return}
        guard let favoriteVC = navController.viewControllers.first as? FavoritesViewController else {return}
        guard let selectedStore = selectedStore else {return}
        for store in favoriteVC.dataManager.stores where store.id == selectedStore.id {return}
        favoriteVC.dataManager.stores.append(selectedStore)
        dataManager.saveFavorites(favoriteVC.dataManager.stores)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = menuArray[indexPath.row]
        return cell
    }
}

