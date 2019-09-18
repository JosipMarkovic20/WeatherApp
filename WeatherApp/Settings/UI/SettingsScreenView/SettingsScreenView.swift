//
//  SettingsScreenView.swift
//  WeatherApp
//
//  Created by Josip Marković on 17/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit



class SettingsScreenView: UIView{
    
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(hex: "#6DA133"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    let unitsLabel: UILabel = {
        let label = UILabel()
        label.text = "Units"
        label.font = UIFont(name: "GothamRounded-Book", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imperialCheckBox: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "square_checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "square_checkmark_uncheck"), for: .normal)
        button.tag = 0
        button.isSelected = false
        return button
    }()
    
    let metricCheckBox: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "square_checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "square_checkmark_uncheck"), for: .normal)
        button.tag = 1
        button.isSelected = true
        return button
    }()
    
    let imperialLabel: UILabel = {
        let label = UILabel()
        label.text = "Imperial"
        label.font = UIFont(name: "GothamRounded-Book", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let metricLabel: UILabel = {
        let label = UILabel()
        label.text = "Metric"
        label.font = UIFont(name: "GothamRounded-Book", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidity: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let wind: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pressure: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pressure_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let humidityView: UIView = {
        let humidityView = UIView()
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.backgroundColor = .clear
        return humidityView
    }()
    
    let windView: UIView = {
        let humidityView = UIView()
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.backgroundColor = .clear
        return humidityView
    }()
    
    let pressureView: UIView = {
        let humidityView = UIView()
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.backgroundColor = .clear
        return humidityView
    }()
    
    let humidityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "checkmark_uncheck"), for: .normal)
        button.isSelected = true
        button.tag = 1
        return button
    }()
    
    let windButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "checkmark_uncheck"), for: .normal)
        button.isSelected = true
        button.tag = 2
        return button
    }()
    
    let pressureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "checkmark_uncheck"), for: .normal)
        button.isSelected = true
        button.tag = 3
        return button
    }()

    
    lazy var statsView: UIStackView = {
        let statsView = UIStackView(arrangedSubviews: [humidityView, windView, pressureView])
        statsView.translatesAutoresizingMaskIntoConstraints = false
        statsView.axis = .horizontal
        statsView.spacing = 20
        statsView.distribution = .fillEqually
        return statsView
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Conditions"
        label.font = UIFont(name: "GothamRounded-Book", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI(){
        guard let tableView = self.tableView else { return }
        self.addSubview(doneButton)
        self.addSubview(tableView)
        self.addSubview(unitsLabel)
        self.addSubview(imperialCheckBox)
        self.addSubview(metricCheckBox)
        self.addSubview(imperialLabel)
        self.addSubview(metricLabel)
        self.addSubview(conditionsLabel)
        self.addSubview(statsView)
        humidityView.addSubview(humidity)
        humidityView.addSubview(humidityButton)
        pressureView.addSubview(pressure)
        pressureView.addSubview(pressureButton)
        windView.addSubview(wind)
        windView.addSubview(windButton)
        
        tableView.register(SettingsScreenTableCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(SettingsScreenHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        guard let tableView = self.tableView else { return }
        
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.28).isActive = true
        
        unitsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        unitsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imperialCheckBox.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02).isActive = true
        imperialCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imperialCheckBox.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imperialCheckBox.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        imperialLabel.topAnchor.constraint(equalTo: imperialCheckBox.topAnchor).isActive = true
        imperialLabel.leadingAnchor.constraint(equalTo: imperialCheckBox.trailingAnchor, constant: 10).isActive = true
        imperialLabel.bottomAnchor.constraint(equalTo: imperialCheckBox.bottomAnchor).isActive = true
        
        metricCheckBox.topAnchor.constraint(equalTo: imperialCheckBox.bottomAnchor).isActive = true
        metricCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        metricCheckBox.heightAnchor.constraint(equalToConstant: 40).isActive = true
        metricCheckBox.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        metricLabel.topAnchor.constraint(equalTo: metricCheckBox.topAnchor).isActive = true
        metricLabel.leadingAnchor.constraint(equalTo: metricCheckBox.trailingAnchor, constant: 10).isActive = true
        metricLabel.bottomAnchor.constraint(equalTo: metricCheckBox.bottomAnchor).isActive = true
        
        conditionsLabel.topAnchor.constraint(equalTo: metricLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        conditionsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        statsView.topAnchor.constraint(equalTo: conditionsLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        statsView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        setupStats()
    }
    
    func setupStats(){
        wind.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
        wind.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
        
        windButton.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
        windButton.bottomAnchor.constraint(equalTo: windView.bottomAnchor, constant: 10).isActive = true
        windButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        windButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        humidity.topAnchor.constraint(equalTo: humidityView.topAnchor).isActive = true
        humidity.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
        
        humidityButton.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor, constant: 10).isActive = true
        humidityButton.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
        humidityButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        humidityButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        pressure.topAnchor.constraint(equalTo: pressureView.topAnchor).isActive = true
        pressure.centerXAnchor.constraint(equalTo: pressureView.centerXAnchor).isActive = true
        
        pressureButton.bottomAnchor.constraint(equalTo: pressureView.bottomAnchor, constant: 10).isActive = true
        pressureButton.centerXAnchor.constraint(equalTo: pressureView.centerXAnchor).isActive = true
        pressureButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pressureButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
