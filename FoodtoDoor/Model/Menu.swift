//
//  Menu.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import Foundation

struct Menu: Codable {
    var categories: [Category]!
    
    init(data: [String:Any]) {
        categories = parseMenuCategories(data: data)
    }
    
    func parseMenuCategories(data:[String:Any]) -> [Category] {
        let menuCategories = data["menu_categories"] as! [[String:Any]]
        var categoryArray = [Category]()
        for i in 0..<menuCategories.count{
            let category = Category(data: menuCategories[i])
            categoryArray.append(category)
        }
        return categoryArray
    }
}

struct Category: Codable {
    let title: String
    
    init(data:[String:Any]){
        title = data["title"] as! String
    }
}
