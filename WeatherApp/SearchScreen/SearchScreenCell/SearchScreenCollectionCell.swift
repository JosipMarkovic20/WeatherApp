//
//  SearchScreenCollectionCell.swift
//  WeatherApp
//
//  Created by Josip Marković on 13/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit



class SearchScreenCollectionCell: UICollectionViewCell{
    
    
    let placeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 20)
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(placeName)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        placeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        placeName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func configureCell(item: Place){
        placeName.text = item.placeName
    }
}
