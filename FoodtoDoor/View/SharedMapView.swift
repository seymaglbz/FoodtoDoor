//
//  SharedMapView.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 16.12.2019.
//  Copyright © 2019 Şeyma Gılbaz. All rights reserved.
//

import UIKit
import MapKit

class SharedMapView: UIView {
    weak var mapView: MKMapView!
    weak var navBar: UINavigationBar!
    weak var addressLabel: UILabel!
    weak var confirmAddressButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        backgroundColor = .systemBackground
        
        setupNavBar()
        setupMapView()
        setupAddressLabel()
        setupConfirmAddressButton()        
    }
    
    func setupNavBar() {
        let navBar = UINavigationBar(frame: frame)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        let navItem = UINavigationItem(title: "Choose an Address")
        navBar.setItems([navItem], animated: true)
        self.navBar = navBar
    }
    
    func setupMapView() {
        let mapView = MKMapView(frame: frame)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        self.mapView = mapView
    }
    
    func setupAddressLabel() {
        let addressLabel = UILabel(frame: frame)
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textColor = .darkGray
        addressLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: self.mapView.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.addressLabel = addressLabel
    }
    
    func setupConfirmAddressButton() {
        let confirmAddressButton = UIButton(frame: frame)
        addSubview(confirmAddressButton)
        confirmAddressButton.backgroundColor = .red
        confirmAddressButton.setTitleColor(.white, for: .normal)
        confirmAddressButton.setTitle("Confirm Address", for: .normal)
        confirmAddressButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmAddressButton.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor),
            confirmAddressButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            confirmAddressButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            confirmAddressButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            confirmAddressButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        self.confirmAddressButton = confirmAddressButton
    }
}

