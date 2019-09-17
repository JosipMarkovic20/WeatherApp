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
import RealmSwift

class SettingsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        return tableView
    }()
    
    
    let viewModel: SettingsScreenViewModel
    weak var coordinatorDelegate: CoordinatorDelegate?
    let disposeBag = DisposeBag()
    weak var settingsDelegate: SettingsDelegate?
    var token: NotificationToken?
    weak var loadPlaceDelegate: LoadPlaceDataDelegate?
    let screenView = SettingsScreenView()
    
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
        setupSubscriptions()
        loadSettings()
        setupUI()
        viewModel.loadLocationsSubject.onNext(true)
        setupTargets()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinatorDelegate?.viewControllerHasFinished()
    }
    
    func loadSettings(){
        viewModel.loadSettingsSubject.onNext(true)
    }
    
    func setupUI(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        screenView.translatesAutoresizingMaskIntoConstraints = false
        screenView.tableView = self.tableView
        screenView.tableView?.delegate = self
        screenView.tableView?.dataSource = self
        view.addSubview(screenView)
        screenView.setupUI()
        setupConstraints()
    }
    
    func setupConstraints(){
        screenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        screenView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        screenView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        screenView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTargets(){
        screenView.pressureButton.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
        screenView.windButton.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
        screenView.humidityButton.addTarget(self, action: #selector(switchConditions), for: .touchUpInside)
        screenView.metricCheckBox.addTarget(self, action: #selector(switchUnits), for: .touchUpInside)
        screenView.imperialCheckBox.addTarget(self, action: #selector(switchUnits), for: .touchUpInside)
        screenView.doneButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    
    
    @objc func dismissViewController(){
        settingsDelegate?.setupBasedOnSettings(settings: viewModel.settings)
        print(viewModel.database.saveSettings(settings: viewModel.settings))
        dismiss(animated: true, completion: nil)
    }
    
    func openSelectedLocation(indexPath: Int){
        guard let locations = viewModel.locations else { return }
        let locationsArray = viewModel.createLocationsArray(results: locations)
        loadPlaceDelegate?.loadPlace(place: locationsArray[indexPath])
        settingsDelegate?.setupBasedOnSettings(settings: viewModel.settings)
        print(viewModel.database.saveSettings(settings: viewModel.settings))
        dismiss(animated: true, completion: nil)
    }
    
    @objc func switchUnits(button: UIButton){
        screenView.imperialCheckBox.isSelected = !screenView.imperialCheckBox.isSelected
        screenView.metricCheckBox.isSelected = !screenView.metricCheckBox.isSelected
        if screenView.imperialCheckBox.isSelected{
            viewModel.settings.unitsType = .imperial
        }else{
            viewModel.settings.unitsType = .metric
        }
    }
    
    @objc func switchConditions(button: UIButton){
        if button.tag == 1{
            screenView.humidityButton.isSelected = !screenView.humidityButton.isSelected
            viewModel.settings.humidityIsHidden = !screenView.humidityButton.isSelected
        }else if button.tag == 2{
            screenView.windButton.isSelected = !screenView.windButton.isSelected
            viewModel.settings.windIsHidden = !screenView.windButton.isSelected
        }else if button.tag == 3{
            screenView.pressureButton.isSelected = !screenView.pressureButton.isSelected
            viewModel.settings.pressureIsHidden = !screenView.pressureButton.isSelected
        }
    }
    
    func setupSettings(){
        screenView.humidityButton.isSelected = !viewModel.settings.humidityIsHidden
        screenView.windButton.isSelected = !viewModel.settings.windIsHidden
        screenView.pressureButton.isSelected = !viewModel.settings.pressureIsHidden
        switch viewModel.settings.unitsType {
        case .metric:
            screenView.metricCheckBox.isSelected = true
            screenView.imperialCheckBox.isSelected = false
        case .imperial:
            screenView.metricCheckBox.isSelected = false
            screenView.imperialCheckBox.isSelected = true
        }
    }
    
    func setupSubscriptions(){
        
        viewModel.settingsLoadedSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {[unowned self] (bool) in
                self.setupSettings()
                print(self.viewModel.database.deleteSettings())
            }).disposed(by: disposeBag)
        
        viewModel.tableReloadSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {[unowned self] (bool) in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.locationsLoadedSubject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {[unowned self] (bool) in
                self.observeLocations()
            }).disposed(by: disposeBag)
        
    }
    
    func toDispose(){
        viewModel.loadLocations(for: viewModel.loadLocationsSubject).disposed(by: disposeBag)
        viewModel.loadSettings(for: viewModel.loadSettingsSubject).disposed(by: disposeBag)
        viewModel.deleteLocation(for: viewModel.deleteLocationSubject).disposed(by: disposeBag)
    }
    
    func observeLocations(){
        guard let locations = viewModel.locations else { return }
        
        self.token = locations.observe({[unowned self] (changes) in
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map({
                    return IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.deleteRows(at: deletions.map({
                    return IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                print("There has been an error: \(error)")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.viewModel.database.deleteLastLocation())
        guard let realmLocations = viewModel.locations else { return }
        let locations = viewModel.createLocationsArray(results: realmLocations)
        print(self.viewModel.database.saveLastLocation(location: locations[indexPath.row]))
        openSelectedLocation(indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingsScreenTableCell  else {
            fatalError("The dequeued cell is not an instance of SettingsScreenTableCell.")
        }
        cell.configureCell(name: viewModel.locations?[indexPath.row].name ?? "Osijek")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.deleteLocationDelegate = self
        cell.geonameId = viewModel.locations?[indexPath.row].geonameId
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? SettingsScreenHeader else {
            return nil
        }
        return headerView
    }
    
}



extension SettingsScreenViewController: DeleteLocationDelegate{
    
    func deleteLocation(geonameId: Int) {
        viewModel.deleteLocationSubject.onNext(geonameId)
    }
}
