//
//  Alert.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasic(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil)}
    }

    static func showUnableToRetrieveLocation(on vc: UIViewController) {
        showBasic(on: vc, with: "To be able to use the app please enable your location services.", message: "")
    }
    
    static func showUnableToRetrieveStores(on vc: UIViewController) {
        showBasic(on: vc, with: "Stores couldn't be loaded!", message: "Please check your internet connection")
    }
    
    static func showUnableToRetrieveMenus(on vc: UIViewController) {
        showBasic(on: vc, with: "Menus couldn't be loaded!", message: "Please check your internet connection")
    }
    
    static func showUnableToSaveToFavorites(on vc: UIViewController) {
        showBasic(on: vc, with: "Failed to save the store to your favorite stores list!", message: "Please try again later")
    }
    
    static func showUnableToLoadFavorites(on vc: UIViewController) {
        showBasic(on: vc, with: "Failed to load your favorite stores!", message: "Please try again later")
    }
   
}

