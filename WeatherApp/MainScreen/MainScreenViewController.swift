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
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 72)
        label.textColor = .white
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Light", size: 24)
        label.textColor = .white
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GothamRounded-Book", size: 36)
        label.text = "Osijek"
        label.textColor = .white
        return label
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
    
    func toDispose(){
        viewModel.collectAndPrepareData(for: viewModel.getWeatherDataSubject).disposed(by: disposeBag)
    }
    
    func setupUI(){
        self.view.addSubview(backgroundGradient)
        self.view.addSubview(bodyImage)
        self.view.addSubview(headerImage)
        self.view.addSubview(temperatureLabel)
        self.view.addSubview(summaryLabel)
        self.view.addSubview(placeLabel)
        
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
        
        
        temperatureLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 12).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        summaryLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        placeLabel.topAnchor.constraint(equalToSystemSpacingBelow: summaryLabel.bottomAnchor, multiplier: 10).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        placeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
        
        temperatureLabel.text = "\(viewModel.weatherResponse?.currently.temperature ?? 0)˚"
        summaryLabel.text = viewModel.weatherResponse?.currently.summary
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
