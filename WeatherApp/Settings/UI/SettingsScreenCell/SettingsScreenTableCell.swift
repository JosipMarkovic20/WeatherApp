//
//  SettingsScreenTableCell.swift
//  WeatherApp
//
//  Created by Josip Marković on 16/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class SettingsScreenTableCell: UITableViewCell{
    
    
    let squareView: UIView = {
        let squareView = UIView()
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = UIColor(hex: "#497183")
        return squareView
    }()
    
    let letterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 24)
        label.textColor = .white
        label.text = "X"
        return label
    }()
    
    let placeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 18)
        label.textColor = .white
        return label
    }()
    
    weak var deleteLocationDelegate: DeleteLocationDelegate?
    var geonameId: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(placeName)
        contentView.addSubview(squareView)
        squareView.addSubview(letterLabel)
        
        setupConstraints()
        let deleteGesture = UITapGestureRecognizer(target: self, action:  #selector(deleteLocation))
        self.squareView.addGestureRecognizer(deleteGesture)
    }
    
    @objc func deleteLocation(){
        deleteLocationDelegate?.deleteLocation(geonameId: geonameId ?? 0)
    }
    
    func setupConstraints(){
        squareView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        squareView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        squareView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        squareView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        letterLabel.centerXAnchor.constraint(equalTo: squareView.centerXAnchor).isActive = true
        letterLabel.centerYAnchor.constraint(equalTo: squareView.centerYAnchor).isActive = true
        
        placeName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        placeName.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: 10).isActive = true
    }
    
    func configureCell(name: String){
        placeName.text = name
    }
    
}
