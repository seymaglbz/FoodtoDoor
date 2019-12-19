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
     
    }
    
    func loadStores() {
        guard let latitude = userLocation?.coordinate.latitude, let longitude = userLocation?.coordinate.longitude else {return}
        NetworkManager.shared.fetchStores(latitude: latitude, longitude: longitude){ stores, errorMessage in
//            guard let stores = stores else {
//                 print("Cannot get stores")
//           //     Alert.showErrorMessage(on: self, with: errorMessage!)
//                DispatchQueue.main.async {
//                    // Alert.showUnableToRetrieveStoresAlert(on: self)
//                    Alert.showErrorMessage(on: self, with: errorMessage!)
//
//                }
//                return
//            }
//            self.dataManager.stores = stores
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            
            
            if let stores = stores {
                print("IT's stores")
                //                DispatchQueue.main.async {
                //                    Alert.showErrorMessage(on: self, with: "Somethings wrong")
                //                }
                
                self.dataManager.stores = stores
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Cannot get stores")
                DispatchQueue.main.async {
                    Alert.showErrorMessage(on: self, with: errorMessage!)
                }
                
            }
        }
    }
}

