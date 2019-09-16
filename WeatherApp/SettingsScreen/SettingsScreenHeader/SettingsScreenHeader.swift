//
//  SettingsScreenHeader.swift
//  WeatherApp
//
//  Created by Josip Marković on 16/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class SettingsScreenHeader: UITableViewHeaderFooterView{
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont(name: "GothamRounded-Book", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = .clear
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI(){
        contentView.addSubview(title)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        title.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
