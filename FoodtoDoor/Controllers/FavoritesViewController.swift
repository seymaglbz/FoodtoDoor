//
//  FavoritesViewController.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import UIKit

class FavoritesViewController: StoreListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataManager.loadFavorites()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

