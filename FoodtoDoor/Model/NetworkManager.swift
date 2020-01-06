//
//  NetworkManager.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    static let shared = NetworkManager()
    static let baseURL = "https://api.doordash.com/"
    let storeURL = baseURL + "v1/store_search/?"
    let menuURL = baseURL + "v2/restaurant/"
    
    private init (){}
    
    //MARK: - Store Networking
    
    func fetchStores(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completed: @escaping (Result<[Store], FTDError>)-> Void) {
        
        let endPoint = "\(storeURL)lat=\(latitude)&lng=\(longitude)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.unableToRetrieveStores))
            return
        }
        print(endPoint)
        
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToRetrieveStores))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let safeData = data else {
                completed(.failure(.unableToRetrieveStores))
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                var storeArray: [Store] = []
                guard let jsonArray = jsonResponse as? [[String: Any]] else {return}
                
                for i in 0..<jsonArray.count{
                    let store = Store(data: jsonArray[i])
                    storeArray.append(store)
                }
                completed(.success(storeArray))
            } catch {
                completed(.failure(.unableToRetrieveStores))
            }
        }
        task.resume()
    }
    
    //MARK: - Menu Networking
    func fetchMenu(with id: Int, completed: @escaping (Result<[String], FTDError>)-> Void) {
        
        let endPoint = "\(menuURL)\(id)/menu/"
        guard let url = URL(string: endPoint) else {return}
        
        print(endPoint)
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let _ = error {
                completed(.failure(.unableToRetrieveMenus))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let safeData = data else {
                completed(.failure(.unableToRetrieveMenus))
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: safeData, options: [])
                var menuTitles: [String] = []
                guard let jsonArray = jsonResponse as? [[String: Any]] else {return}
                
                for i in 0..<jsonArray.count{
                    let menu = Menu(data: jsonArray[i])
                    guard let menuCategories = menu.categories else {return}
                    
                    for j in 0..<menuCategories.count{
                        let title = menuCategories[j].title
                        menuTitles.append(title)
                    }
                }
                completed(.success(menuTitles))
            } catch {
                completed(.failure(.unableToRetrieveMenus))
            }
        }
        task.resume()
    }
}

