//
//  StoreListViewController.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import UIKit

class StoreListViewController: UIViewController {
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    var dataManager = DataManager()
    lazy var dataSourceProvider = DataSourceProvider(dataManager: dataManager)
    lazy var searchBarManager = SearchBar(dataManager: dataManager)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setupTableView()
        setupSearchBar()
        setupNavBar()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = dataSourceProvider
        tableView.delegate = dataSourceProvider
        dataSourceProvider.delegate = self
        
        tableView.rowHeight = 90
        tableView.pin(to: view)
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBarManager.delegate = self
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = .red
        navigationItem.title = "Food to Door"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-search"), style: .plain, target: self, action: #selector(searchForStores))
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-address"), style: .plain, target: self, action: nil)
    }
    
    @objc func searchForStores(){
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = searchBarManager
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.titleView = searchBar
    }
}

//MARK: - DataSourceProviderDelegate, SearchBarDelegate
extension StoreListViewController: DataSourceProviderDelegate, SearchBarDelegate{
    
    func selectedCell(row: Int) {
        let storeVC = StoreViewController()
        storeVC.selectedStore = dataManager.isSearching ? dataManager.searchedStores[row] : dataManager.stores[row]
        navigationController?.pushViewController(storeVC, animated: true)
    }
    
    func searchCancelButtonClicked() {
        navigationItem.titleView = nil
        setupNavBar()
        dataManager.isSearching = false
        searchBar.searchTextField.text = ""
        tableView.reloadData()
    }
    
    func setSearchedStores() {
        tableView.reloadData()
    }
}

