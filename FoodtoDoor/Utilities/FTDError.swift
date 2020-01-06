//
//  FTDError.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 6.01.2020.
//  Copyright © 2020 Şeyma Gılbaz. All rights reserved.
//

import Foundation

enum FTDError: String, Error {    
    case unableToRetrieveLocation = "To be able to use the app please enable your location services."
    case unableToRetrieveStores = "Stores couldn't be loaded. Please check your internet connection."
    case unableToRetrieveMenus = "Menus couldn't be loaded. Please check your internet connection."
    case unableToSaveToFavorites = "Failed to save the store to your favorite stores list. Please try again later"
    case unableToLoadFavorites = "Failed to load your favorite stores. Please try again later."
    case invalidResponse = "Invalid response from the server. Please try again."
    case noAvaliableStore = "There is no available stores around you."
}
