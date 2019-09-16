//
//  SettingsScreenViewController.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Hue

class SettingsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(hex: "#6DA133"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        return tableView
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
        button.addTarget(self, action: #selector(switchUnits), for: .touchUpInside)
        return button
    }()
    
    let metricCheckBox: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "square_checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "square_checkmark_uncheck"), for: .normal)
        button.tag = 1
        button.isSelected = true
        button.addTarget(self, action: #selector(switchUnits), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
        return button
    }()
    
    let windButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "checkmark_uncheck"), for: .normal)
        button.isSelected = true
        button.tag = 2
        button.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
        return button
    }()
    
    let pressureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark_check"), for: .selected)
        button.setImage(UIImage(named: "checkmark_uncheck"), for: .normal)
        button.isSelected = true
        button.tag = 3
        button.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
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
    
    
    let viewModel: SettingsScreenViewModel
    weak var coordinatorDelegate: CoordinatorDelegate?
    let disposeBag = DisposeBag()
    weak var settingsDelegate: SettingsDelegate?
    
    init(viewModel: SettingsScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Deinit: \(self)")
    }
    
    
    override func viewDidLoad() {
        toDispose()
        loadSettings()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinatorDelegate?.viewControllerHasFinished()
    }
    
    func loadSettings(){
        viewModel.loadSettingsSubject.onNext(true)
        setupSettings()
        print(viewModel.database.deleteSettings())
    }
    
    func setupUI(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(doneButton)
        view.addSubview(tableView)
        view.addSubview(unitsLabel)
        view.addSubview(imperialCheckBox)
        view.addSubview(metricCheckBox)
        view.addSubview(imperialLabel)
        view.addSubview(metricLabel)
        view.addSubview(conditionsLabel)
        view.addSubview(statsView)
        humidityView.addSubview(humidity)
        humidityView.addSubview(humidityButton)
        pressureView.addSubview(pressure)
        pressureView.addSubview(pressureButton)
        windView.addSubview(wind)
        windView.addSubview(windButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsScreenTableCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(SettingsScreenHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.28).isActive = true
        
        unitsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        unitsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imperialCheckBox.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02).isActive = true
        imperialCheckBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imperialCheckBox.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imperialCheckBox.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        imperialLabel.topAnchor.constraint(equalTo: imperialCheckBox.topAnchor).isActive = true
        imperialLabel.leadingAnchor.constraint(equalTo: imperialCheckBox.trailingAnchor, constant: 10).isActive = true
        imperialLabel.bottomAnchor.constraint(equalTo: imperialCheckBox.bottomAnchor).isActive = true
        
        metricCheckBox.topAnchor.constraint(equalTo: imperialCheckBox.bottomAnchor).isActive = true
        metricCheckBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        metricCheckBox.heightAnchor.constraint(equalToConstant: 40).isActive = true
        metricCheckBox.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        metricLabel.topAnchor.constraint(equalTo: metricCheckBox.topAnchor).isActive = true
        metricLabel.leadingAnchor.constraint(equalTo: metricCheckBox.trailingAnchor, constant: 10).isActive = true
        metricLabel.bottomAnchor.constraint(equalTo: metricCheckBox.bottomAnchor).isActive = true
        
        conditionsLabel.topAnchor.constraint(equalTo: metricLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        conditionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        statsView.topAnchor.constraint(equalTo: conditionsLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05).isActive = true
        statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
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
    
    @objc func dismissViewController(){
        settingsDelegate?.setupBasedOnSettings(settings: viewModel.settings)
        print(viewModel.database.saveSettings(settings: viewModel.settings))
        dismiss(animated: true, completion: nil)
    }
    
    @objc func switchUnits(button: UIButton){
        imperialCheckBox.isSelected = !imperialCheckBox.isSelected
        metricCheckBox.isSelected = !metricCheckBox.isSelected
        if imperialCheckBox.isSelected{
            viewModel.settings.unitsType = .imperial
        }else{
            viewModel.settings.unitsType = .metric
        }
    }
    
    @objc func switchConditions(button: UIButton){
        if button.tag == 1{
            humidityButton.isSelected = !humidityButton.isSelected
            viewModel.settings.humidityIsHidden = !humidityButton.isSelected
        }else if button.tag == 2{
            windButton.isSelected = !windButton.isSelected
            viewModel.settings.windIsHidden = !windButton.isSelected
        }else if button.tag == 3{
            pressureButton.isSelected = !pressureButton.isSelected
            viewModel.settings.pressureIsHidden = !pressureButton.isSelected
        }
    }
    
    func setupSettings(){
        humidityButton.isSelected = !viewModel.settings.humidityIsHidden
        windButton.isSelected = !viewModel.settings.windIsHidden
        pressureButton.isSelected = !viewModel.settings.pressureIsHidden
        switch viewModel.settings.unitsType {
        case .metric:
            metricCheckBox.isSelected = true
            imperialCheckBox.isSelected = false
        case .imperial:
            metricCheckBox.isSelected = false
            imperialCheckBox.isSelected = true
        }
    }
    
    func toDispose(){
        viewModel.loadSettings(for: viewModel.loadSettingsSubject).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingsScreenTableCell  else {
            fatalError("The dequeued cell is not an instance of SettingsScreenTableCell.")
        }
        cell.configureCell(item: Place(placeName: "Podvinje", lng: 00, lat: 00, countryCode: "HR"))
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? SettingsScreenHeader else {
            return nil
        }
        return headerView
    }
    
}
