//
//  FTDAlertContainerView.swift
//  FoodtoDoor
//
//  Created by Şeyma Gılbaz on 6.01.2020.
//  Copyright © 2020 Şeyma Gılbaz. All rights reserved.
//

import UIKit

class FTDAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
