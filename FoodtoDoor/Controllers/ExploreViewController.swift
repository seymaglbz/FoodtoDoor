//
//  ExploreViewController.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import UIKit
import CoreLocation

class ExploreViewController: StoreListViewController {
    
    var userLocation: CLLocation?
    var stores: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStores()        
        self.dataManager.isEditable = false
    }
    
    func loadStores() {
        guard let latitude = userLocation?.coordinate.latitude, let longitude = userLocation?.coordinate.longitude else {return}
        NetworkManager.shared.fetchStores(latitude: latitude, longitude: longitude){ result in
            
            switch result {
            case .success(let stores):
                if stores.isEmpty {
                    DispatchQueue.main.async {
                        self.presentFTDAlertOnMainThread(title: "Sorry 😔", message: FTDError.noAvaliableStore.rawValue, buttonTitle: "Ok")
                    }
                }
                self.stores = stores
                self.dataManager.stores = stores
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentFTDAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

