//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Hue

class MainScreenViewController: UIViewController{
    
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
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 36)
        label.text = "Osijek"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let minAndMaxTemp: UIView = {
        let minAndMaxView = UIView()
        minAndMaxView.translatesAutoresizingMaskIntoConstraints = false
        return minAndMaxView
    }()
    
    let statsView: UIView = {
        let statsView = UIView()
        statsView.translatesAutoresizingMaskIntoConstraints = false
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
    
    let disposeBag = DisposeBag()
    let viewModel: MainScreenViewModel
    let gradientColors = GradientColors()
    let loader = LoaderViewController()
    
    init(viewModel: MainScreenViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        toDispose()
        setupSubscriptions()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupSearchBar()
    }
    
    func toDispose(){
        viewModel.collectAndPrepareData(for: viewModel.getWeatherDataSubject).disposed(by: disposeBag)
    }
    
    func setupSearchBar(){
        let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(named: "search_icon")!
        let imageView:UIImageView = UIImageView.init(image: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: "#6DA133")
        searchTextField.leftView = nil
        searchTextField.placeholder = "Search"
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextField.ViewMode.always
        
        if let backgroundview = searchTextField.subviews.first {
            backgroundview.layer.cornerRadius = 18;
            backgroundview.clipsToBounds = true;
        }
    }
    
    func setupUI(){
        self.view.addSubview(backgroundGradient)
        self.view.addSubview(bodyImage)
        self.view.addSubview(headerImage)
        self.view.addSubview(temperatureLabel)
        self.view.addSubview(summaryLabel)
        self.view.addSubview(placeLabel)
        self.view.addSubview(minAndMaxTemp)
        self.view.addSubview(statsView)
        self.view.addSubview(settingsButton)
        self.view.addSubview(searchBar)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        bodyImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bodyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bodyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundGradient.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundGradient.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundGradient.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundGradient.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        temperatureLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 15).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        summaryLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        placeLabel.topAnchor.constraint(equalToSystemSpacingBelow: summaryLabel.bottomAnchor, multiplier: 15).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        minAndMaxTemp.topAnchor.constraint(equalToSystemSpacingBelow: placeLabel.bottomAnchor, multiplier: 5).isActive = true
        minAndMaxTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        minAndMaxTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        minAndMaxTemp.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        statsView.topAnchor.constraint(equalToSystemSpacingBelow: minAndMaxTemp.bottomAnchor, multiplier: 5).isActive = true
        statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: settingsButton.trailingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func getData(){
        viewModel.getWeatherDataSubject.onNext([18.6938889,45.5511111])
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
        
        temperatureLabel.text = "\(Int(viewModel.weatherResponse?.currently.temperature ?? 0))˚"
        summaryLabel.text = viewModel.weatherResponse?.currently.summary
        
        setupMinAndMax()
        setupStats()
    }
    
    func setupMinAndMax(){
        let minTempLabel = UILabel()
        let minLabel = UILabel()
        let maxTempLabel = UILabel()
        let maxLabel = UILabel()
        let divider = UIView()
        divider.backgroundColor = .white
        
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        minAndMaxTemp.addSubview(minTempLabel)
        minAndMaxTemp.addSubview(minLabel)
        minAndMaxTemp.addSubview(maxTempLabel)
        minAndMaxTemp.addSubview(maxLabel)
        minAndMaxTemp.addSubview(divider)
        
        divider.heightAnchor.constraint(equalToConstant: 60).isActive = true
        divider.centerXAnchor.constraint(equalTo: minAndMaxTemp.centerXAnchor).isActive = true
        divider.centerYAnchor.constraint(equalTo: minAndMaxTemp.centerYAnchor).isActive = true
        divider.widthAnchor.constraint(equalToConstant: 3).isActive = true
        
        minTempLabel.topAnchor.constraint(equalTo: minAndMaxTemp.topAnchor, constant: 5).isActive = true
        minTempLabel.trailingAnchor.constraint(equalTo: divider.leadingAnchor).isActive = true
        minTempLabel.leadingAnchor.constraint(equalTo: minAndMaxTemp.leadingAnchor).isActive = true
        minTempLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        minLabel.bottomAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: -5).isActive = true
        minLabel.trailingAnchor.constraint(equalTo: divider.leadingAnchor).isActive = true
        minLabel.leadingAnchor.constraint(equalTo: minAndMaxTemp.leadingAnchor).isActive = true
        minLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        maxTempLabel.topAnchor.constraint(equalTo: minAndMaxTemp.topAnchor, constant: 5).isActive = true
        maxTempLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor).isActive = true
        maxTempLabel.trailingAnchor.constraint(equalTo: minAndMaxTemp.trailingAnchor).isActive = true
        maxTempLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        maxLabel.bottomAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: -5).isActive = true
        maxLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor).isActive = true
        maxLabel.trailingAnchor.constraint(equalTo: minAndMaxTemp.trailingAnchor).isActive = true
        maxLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        minLabel.text = "Min"
        minLabel.textColor = .white
        minLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        minLabel.textAlignment = .center
        
        maxLabel.text = "Max"
        maxLabel.textColor = .white
        maxLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        maxLabel.textAlignment = .center
        
        let temperatures = viewModel.findMinAndMaxTemperatures()
        
        minTempLabel.text = "\(temperatures.min.rounded(toPlaces: 1))˚F"
        minTempLabel.textColor = .white
        minTempLabel.font = UIFont(name: "GothamRounded-Light", size: 24)
        minTempLabel.textAlignment = .center
        
        maxTempLabel.text = "\(temperatures.max.rounded(toPlaces: 1))˚F"
        maxTempLabel.textColor = .white
        maxTempLabel.font = UIFont(name: "GothamRounded-Light", size: 24)
        maxTempLabel.textAlignment = .center
        
    }
    
    func setupStats(){
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        
        let windLabel = UILabel()
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.textAlignment = .center
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        
        let pressureLabel = UILabel()
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        
        statsView.addSubview(humidityLabel)
        statsView.addSubview(humidity)
        statsView.addSubview(windLabel)
        statsView.addSubview(wind)
        statsView.addSubview(pressureLabel)
        statsView.addSubview(pressure)
        
        wind.topAnchor.constraint(equalTo: statsView.topAnchor).isActive = true
        wind.centerXAnchor.constraint(equalTo: statsView.centerXAnchor).isActive = true
        wind.heightAnchor.constraint(equalToConstant: 40).isActive = true
        wind.widthAnchor.constraint(equalToConstant: 55).isActive = true
        
        windLabel.topAnchor.constraint(equalTo: wind.bottomAnchor, constant: 10).isActive = true
        windLabel.centerXAnchor.constraint(equalTo: statsView.centerXAnchor).isActive = true
        windLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        humidity.topAnchor.constraint(equalTo: statsView.topAnchor).isActive = true
        humidity.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 40).isActive = true
        humidity.heightAnchor.constraint(equalToConstant: 40).isActive = true
        humidity.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: humidity.bottomAnchor, constant: 10).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 30).isActive = true
        humidityLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        pressure.topAnchor.constraint(equalTo: statsView.topAnchor).isActive = true
        pressure.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: -55).isActive = true
        pressure.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pressure.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        pressureLabel.topAnchor.constraint(equalTo: pressure.bottomAnchor, constant: 10).isActive = true
        pressureLabel.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: -30).isActive = true
        pressureLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        let humidityText = viewModel.weatherResponse?.currently.humidity ?? 0
        humidityLabel.text = "\(humidityText.rounded(toPlaces: 1))%"
        
        let windText = viewModel.weatherResponse?.currently.windSpeed ?? 0
        windLabel.text = "\(windText.rounded(toPlaces: 1)) mph"
        
        let pressureText = Int(viewModel.weatherResponse?.currently.pressure ?? 0)
        pressureLabel.text = "\(pressureText) hpa"
    }
    
    
    func setupSubscriptions(){
        
        viewModel.setupScreenSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler)
            .subscribe {[unowned self] (enumCase) in
                guard let enumCase = enumCase.element else { return }
                self.setupScreen(enumCase: enumCase)
            }.disposed(by: disposeBag)
        
        
        viewModel.loaderSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler)
            .subscribe {[unowned self] (bool) in
                if bool.element ?? false{
                    self.addChild(self.loader)
                    self.loader.view.frame = self.view.frame
                    self.view.addSubview(self.loader.view)
                    self.loader.didMove(toParent: self)
                }else{
                    self.loader.willMove(toParent: nil)
                    self.loader.view.removeFromSuperview()
                    self.loader.removeFromParent()
                }
            }.disposed(by: disposeBag)
    }
    
    
}
