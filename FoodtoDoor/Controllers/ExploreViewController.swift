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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStores()
        
        self.dataManager.isEditable = false
    }
    
    func loadStores() {
        guard let latitude = userLocation?.coordinate.latitude, let longitude = userLocation?.coordinate.longitude else {return}
        NetworkManager.shared.fetchStores(latitude: latitude, longitude: longitude){ stores in
            guard let stores = stores else {
                DispatchQueue.main.async {
                    Alert.showUnableToRetrieveStores(on: self)
                }
                return
            }
            self.dataManager.stores = stores
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

