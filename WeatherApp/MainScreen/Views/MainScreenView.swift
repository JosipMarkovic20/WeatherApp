//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Josip Marković on 17/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class MainScreenView: UIView, UISearchBarDelegate{
    
    let bodyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "body_image-clear-day")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header_image-clear-day")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backgroundGradient: GradientView = {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
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
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 72)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "24˚"
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Sunny"
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 36)
        label.text = "Osijek"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let minAndMaxTemp: UIView = {
        let minAndMaxView = UIView()
        minAndMaxView.translatesAutoresizingMaskIntoConstraints = false
        return minAndMaxView
    }()
    
    lazy var statsView: UIStackView = {
        let statsView = UIStackView(arrangedSubviews: [humidityView, windView, pressureView])
        statsView.translatesAutoresizingMaskIntoConstraints = false
        statsView.axis = .horizontal
        statsView.spacing = 20
        statsView.distribution = .fillEqually
        return statsView
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settings_icon"), for: .normal)
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textAlignment = .center
        label.text = "18˚C"
        return label
    }()
    let minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min"
        label.textColor = .white
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        return label
    }()
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textAlignment = .center
        label.text = "30˚C"
        return label
    }()
    let maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max"
        label.textColor = .white
        label.font = UIFont(name: "GothamRounded-Light", size: 20)
        label.textAlignment = .center
        return label
    }()
    let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        return divider
    }()
    
    let humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        humidityLabel.text = "60%"
        return humidityLabel
    }()
    
    let windLabel: UILabel = {
        let windLabel = UILabel()
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.textAlignment = .center
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        windLabel.text = "1.2km/h"
        return windLabel
    }()
    
    let pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        pressureLabel.text = "1024hpa"
        return pressureLabel
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
    
    let gradientColors = GradientColors()
    var openSearchScreen: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        openSearchScreen()
        return false
    }
    
    func setupUI(){
        self.addSubview(backgroundGradient)
        self.addSubview(bodyImage)
        self.addSubview(headerImage)
        self.addSubview(temperatureLabel)
        self.addSubview(summaryLabel)
        self.addSubview(placeLabel)
        self.addSubview(minAndMaxTemp)
        self.addSubview(statsView)
        self.addSubview(settingsButton)
        self.addSubview(searchBar)
        minAndMaxTemp.addSubview(minTempLabel)
        minAndMaxTemp.addSubview(minLabel)
        minAndMaxTemp.addSubview(maxTempLabel)
        minAndMaxTemp.addSubview(maxLabel)
        minAndMaxTemp.addSubview(divider)
        humidityView.addSubview(humidityLabel)
        humidityView.addSubview(humidity)
        windView.addSubview(windLabel)
        windView.addSubview(wind)
        pressureView.addSubview(pressureLabel)
        pressureView.addSubview(pressure)
        
        searchBar.delegate = self
        setupConstraints()
    }
    
    func setupConstraints(){
        bodyImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bodyImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bodyImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        headerImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        backgroundGradient.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundGradient.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundGradient.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundGradient.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height * 0.15).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        placeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        placeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        minAndMaxTemp.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        minAndMaxTemp.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        minAndMaxTemp.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        minAndMaxTemp.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        statsView.topAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        statsView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        settingsButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        searchBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: settingsButton.trailingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    
    func setupScreen(enumCase: LayoutSetupEnum){
        let dayGradient = [gradientColors.dayColorTop, gradientColors.dayColorBottom].gradient()
        let nightGradient = [gradientColors.nightColorTop, gradientColors.nightColorBottom].gradient()
        let rainGradient = [gradientColors.rainColorTop, gradientColors.rainColorBottom].gradient()
        let snowGradient = [gradientColors.snowColorTop, gradientColors.snowColorBottom].gradient()
        let fogGradient = [gradientColors.fogColorTop, gradientColors.fogColorBottom].gradient()
        
        switch enumCase{
        case .clearDay:
            bodyImage.image = UIImage(named: "body_image-clear-day")
            headerImage.image = UIImage(named: "header_image-clear-day")
            backgroundGradient.gradient = dayGradient
        case .clearNight:
            bodyImage.image = UIImage(named: "body_image-clear-night")
            headerImage.image = UIImage(named: "header_image-clear-night")
            backgroundGradient.gradient = nightGradient
        case .rain:
            bodyImage.image = UIImage(named: "body_image-rain")
            headerImage.image = UIImage(named: "header-image_rain")
            backgroundGradient.gradient = rainGradient
        case .snow:
            bodyImage.image = UIImage(named: "body_image-snow")
            headerImage.image = UIImage(named: "header_image-snow")
            backgroundGradient.gradient = snowGradient
        case .sleet:
            bodyImage.image = UIImage(named: "body_image-sleet")
            headerImage.image = UIImage(named: "header_image-sleet")
            backgroundGradient.gradient = snowGradient
        case .wind:
            bodyImage.image = UIImage(named: "body_image-wind")
            headerImage.image = UIImage(named: "header_image-wind")
            backgroundGradient.gradient = dayGradient
        case .fog:
            bodyImage.image = UIImage(named: "body_image-fog")
            headerImage.image = UIImage(named: "header_image-fog")
            backgroundGradient.gradient = fogGradient
        case .cloudy:
            bodyImage.image = UIImage(named: "body_image-cloudy")
            headerImage.image = UIImage(named: "header_image-cloudy")
            backgroundGradient.gradient = dayGradient
        case .partlyCloudyDay:
            bodyImage.image = UIImage(named: "body_image-partly-cloudy-day")
            headerImage.image = UIImage(named: "header_image-partly-cloudy-day")
            backgroundGradient.gradient = dayGradient
        case .partlyCloudyNight:
            bodyImage.image = UIImage(named: "body_image-partly-cloudy-night")
            headerImage.image = UIImage(named: "header_image-partly-cloudy-night")
            backgroundGradient.gradient = nightGradient
        case .hail:
            bodyImage.image = UIImage(named: "body_image-hail")
            headerImage.image = UIImage(named: "header_image-hail")
            backgroundGradient.gradient = rainGradient
        case .thunderstorm:
            bodyImage.image = UIImage(named: "body_image-thunderstorm")
            headerImage.image = UIImage(named: "header_image-thunderstorm")
            backgroundGradient.gradient = rainGradient
        case .tornado:
            bodyImage.image = UIImage(named: "body_image-tornado")
            headerImage.image = UIImage(named: "header_image-tornado")
            backgroundGradient.gradient = rainGradient
        }
        backgroundGradient.setupUI()
        
        
        
        setupMinAndMax()
        setupStats()
    }
      
        func setupMinAndMax(){
            divider.heightAnchor.constraint(equalToConstant: 60).isActive = true
            divider.centerXAnchor.constraint(equalTo: minAndMaxTemp.centerXAnchor).isActive = true
            divider.centerYAnchor.constraint(equalTo: minAndMaxTemp.centerYAnchor).isActive = true
            divider.widthAnchor.constraint(equalToConstant: 3).isActive = true
            
            minTempLabel.topAnchor.constraint(equalTo: minAndMaxTemp.topAnchor, constant: 5).isActive = true
            minTempLabel.trailingAnchor.constraint(equalTo: divider.leadingAnchor).isActive = true
            minTempLabel.leadingAnchor.constraint(equalTo: minAndMaxTemp.leadingAnchor).isActive = true
            
            minLabel.bottomAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: -5).isActive = true
            minLabel.trailingAnchor.constraint(equalTo: divider.leadingAnchor).isActive = true
            minLabel.leadingAnchor.constraint(equalTo: minAndMaxTemp.leadingAnchor).isActive = true
            
            maxTempLabel.topAnchor.constraint(equalTo: minAndMaxTemp.topAnchor, constant: 5).isActive = true
            maxTempLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor).isActive = true
            maxTempLabel.trailingAnchor.constraint(equalTo: minAndMaxTemp.trailingAnchor).isActive = true
            
            maxLabel.bottomAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: -5).isActive = true
            maxLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor).isActive = true
            maxLabel.trailingAnchor.constraint(equalTo: minAndMaxTemp.trailingAnchor).isActive = true
            
        }
        
        
        func setupStats(){
            wind.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
            wind.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
            
            windLabel.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
            windLabel.bottomAnchor.constraint(equalTo: windView.bottomAnchor).isActive = true
            
            humidity.topAnchor.constraint(equalTo: humidityView.topAnchor).isActive = true
            humidity.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
            
            humidityLabel.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor).isActive = true
            humidityLabel.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
            
            pressure.topAnchor.constraint(equalTo: pressureView.topAnchor).isActive = true
            pressure.centerXAnchor.constraint(equalTo: pressureView.centerXAnchor).isActive = true
            
            pressureLabel.bottomAnchor.constraint(equalTo: pressureView.bottomAnchor).isActive = true
            pressureLabel.centerXAnchor.constraint(equalTo: pressureView.centerXAnchor).isActive = true
            
        }
}
