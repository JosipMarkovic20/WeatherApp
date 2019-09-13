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

class MainScreenViewController: UIViewController, UISearchBarDelegate{
    
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
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
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
        return humidityLabel
    }()
    
    let windLabel: UILabel = {
        let windLabel = UILabel()
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.textAlignment = .center
        windLabel.textColor = .white
        windLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
        return windLabel
    }()
    
    let pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.font = UIFont(name: "GothamRounded-Light", size: 20)
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
    
    let disposeBag = DisposeBag()
    let viewModel: MainScreenViewModel
    let gradientColors = GradientColors()
    let loader = LoaderViewController()
    var openSearchScreen: () -> Void = {}
    var openSettingsScreen: () -> Void = {}
    var placeCoordinates: [Double] = [18.6938889,45.5511111]
    
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
        
        setupConstraints()
        searchBar.delegate = self
    }
    
    func getData(){
        viewModel.getWeatherDataSubject.onNext(placeCoordinates)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        openSearchScreen()
        return false
    }
    
    @objc func openSettings(){
        self.openSettingsScreen()
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
        
        temperatureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height * 0.15).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        placeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        minAndMaxTemp.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        minAndMaxTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        minAndMaxTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        minAndMaxTemp.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        statsView.topAnchor.constraint(equalTo: minAndMaxTemp.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
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
        
        let temperatures = viewModel.findMinAndMaxTemperatures()
        
        minTempLabel.text = "\(temperatures.min.rounded(toPlaces: 1))˚C"
        maxTempLabel.text = "\(temperatures.max.rounded(toPlaces: 1))˚C"
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
        
        let humidityText = viewModel.weatherResponse?.currently.humidity ?? 0 * 100
        humidityLabel.text = "\(humidityText.rounded(toPlaces: 1) * 100)%"
        
        let windText = viewModel.weatherResponse?.currently.windSpeed ?? 0
        windLabel.text = "\(windText.rounded(toPlaces: 1)) km/h"
        
        let pressureText = Int(viewModel.weatherResponse?.currently.pressure ?? 0)
        pressureLabel.text = "\(pressureText) hpa"
    }
}
