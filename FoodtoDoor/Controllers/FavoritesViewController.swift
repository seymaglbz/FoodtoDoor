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

        self.dataManager.isEditable = true
        
        do {
            try self.dataManager.loadFavorites()
        } catch {
            DispatchQueue.main.async {
                self.presentFTDAlertOnMainThread(title: "Something went wrong", message: FTDError.unableToLoadFavorites.rawValue, buttonTitle: "Ok")
            }
        }
   }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        do {
            try self.dataManager.loadFavorites()
        } catch {
            DispatchQueue.main.async {
                self.presentFTDAlertOnMainThread(title: "Something went wrong", message: FTDError.unableToLoadFavorites.rawValue, buttonTitle: "Ok")
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

