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
    
    
    let disposeBag = DisposeBag()
    let viewModel: MainScreenViewModel
    let loader = LoaderViewController()
    var openSettingsScreen: () -> Void = {}
    var unitsType: UnitsTypeEnum = .metric
    let screenView = MainScreenView()
    
    init(viewModel: MainScreenViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        toDispose()
        setupSubscriptions()
        viewModel.getLocation()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupSearchBar()
    }
    
    func setupUI(){
        screenView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(screenView)
        screenView.settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        setupConstraints()
    }
    
    func setupConstraints(){
        screenView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        screenView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        screenView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        screenView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func toDispose(){
        viewModel.loadSettings(for: viewModel.loadSettingsSubject).disposed(by: disposeBag)
        viewModel.collectAndPrepareData(for: viewModel.getWeatherDataSubject).disposed(by: disposeBag)
        viewModel.loadLastLocation(for: viewModel.loadLastLocationSubject).disposed(by: disposeBag)
    }
    
    
    func setupSearchBar(){
        let searchTextField:UITextField = screenView.searchBar.subviews[0].subviews.last as! UITextField
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
    
    
    func getData(){
        viewModel.loadSettingsSubject.onNext(true)
        viewModel.getWeatherDataSubject.onNext(viewModel.lastPlaceCoordinates)
    }
    
    func setupScreenData(){
        
        let temperature = viewModel.weatherResponse?.currently.temperature ?? 0
        
        if unitsType == .metric{
            screenView.temperatureLabel.text = "\(Int(temperature))˚"
        }else if unitsType == .imperial{
            screenView.temperatureLabel.text = "\((temperature * 9/5).rounded(toPlaces: 1) + 32)˚"
        }
        
        screenView.summaryLabel.text = viewModel.weatherResponse?.currently.summary
        
        let temperatures = viewModel.findMinAndMaxTemperatures()
        
        if unitsType == .metric{
            screenView.minTempLabel.text = "\(temperatures.min.rounded(toPlaces: 1))˚C"
            screenView.maxTempLabel.text = "\(temperatures.max.rounded(toPlaces: 1))˚C"
        }else if unitsType == .imperial{
            screenView.minTempLabel.text = "\((temperatures.min * 9/5 + 32).rounded(toPlaces: 1))˚F"
            screenView.maxTempLabel.text = "\((temperatures.max * 9/5 + 32).rounded(toPlaces: 1))˚F"
        }
        let humidityText = (viewModel.weatherResponse?.currently.humidity ?? 0) * 100
        screenView.humidityLabel.text = "\(humidityText.rounded(toPlaces: 2))%"
        
        let windText = viewModel.weatherResponse?.currently.windSpeed ?? 0
        
        if unitsType == .metric{
            screenView.windLabel.text = "\(windText.rounded(toPlaces: 1)) km/h"
        }else if unitsType == .imperial{
            screenView.windLabel.text = "\((windText / 1.6).rounded(toPlaces: 1)) mph"
        }
        
        let pressureText = Int(viewModel.weatherResponse?.currently.pressure ?? 0)
        screenView.pressureLabel.text = "\(pressureText) hpa"
        
    }
    
    @objc func openSettings(){
        self.openSettingsScreen()
    }
    
    func showPopUp(){
        let alert = UIAlertController(title: "Error", message: "Something went wrong.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    func setupSubscriptions(){
        
        viewModel.setupScreenSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler).subscribe(onNext: { [unowned self] (enumCase) in
                self.screenView.setupScreen(enumCase: enumCase)
                self.setupScreenData()
                self.screenView.placeLabel.text = self.viewModel.lastPlaceName
                }, onError: { (error) in
                    print("Error setting up screen ", error)
            }).disposed(by: disposeBag)
        
        viewModel.settingsLoadedSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler)
            .subscribe(onNext: {[unowned self] (bool) in
                self.setupBasedOnSettings(settings: self.viewModel.settings)
                }, onError: { (error) in
                    print("Error loading settings ", error)
            }).disposed(by: disposeBag)
        
        viewModel.loaderSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler).subscribe(onNext: { [unowned self] (bool) in
                if bool{
                    self.addChild(self.loader)
                    self.loader.view.frame = self.view.frame
                    self.view.addSubview(self.loader.view)
                    self.loader.didMove(toParent: self)
                }else{
                    self.loader.willMove(toParent: nil)
                    self.loader.view.removeFromSuperview()
                    self.loader.removeFromParent()
                }
                }, onError: { (error) in
                    print("Error displaying loader ", error)
            }).disposed(by: disposeBag)
        
        
        viewModel.locationLoadedSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler)
            .subscribe(onNext: {[unowned self] (string) in
                self.screenView.placeLabel.text = string
                }, onError: { (error) in
                    print("Error loading location ", error)
            }).disposed(by: disposeBag)
        
        viewModel.popUpSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.subscribeScheduler)
            .subscribe(onNext: {[unowned self] (bool) in
                self.showPopUp()
                }, onError: { (error) in
                    print("Error displaying popUp ", error)
            }).disposed(by: disposeBag)
    }
    
    
}


extension MainScreenViewController: SettingsDelegate{
    
    func setupBasedOnSettings(settings: SettingsData) {
        screenView.windView.isHidden = settings.windIsHidden
        screenView.humidityView.isHidden = settings.humidityIsHidden
        screenView.pressureView.isHidden = settings.pressureIsHidden
        
        unitsType = settings.unitsType
        screenView.setupScreen(enumCase: viewModel.checkIcon())
        setupScreenData()
    }
    
}
