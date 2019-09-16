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
    
    
    let viewModel: SettingsScreenViewModel
    weak var coordinatorDelegate: CoordinatorDelegate?
    let disposeBag = DisposeBag()
    
    
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
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinatorDelegate?.viewControllerHasFinished()
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
        tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25).isActive = true
        
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
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func dismissViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func switchUnits(button: UIButton){
        if button.tag == 0{
            if imperialCheckBox.isSelected{
                imperialCheckBox.isSelected = false
                metricCheckBox.isSelected = true
            }else{
                imperialCheckBox.isSelected = true
                metricCheckBox.isSelected = false
            }
        }else if button.tag == 1{
            if metricCheckBox.isSelected{
                imperialCheckBox.isSelected = true
                metricCheckBox.isSelected = false
            }else{
                imperialCheckBox.isSelected = false
                metricCheckBox.isSelected = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingsScreenTableCell  else {
            fatalError("The dequeued cell is not an instance of SettingsScreenTableCell.")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? SettingsScreenHeader else {
            return nil
        }
        return headerView
    }
    
}
