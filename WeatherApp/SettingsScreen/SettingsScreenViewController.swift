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

class SettingsScreenViewController: UIViewController{
    
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
    
    
    
    func setupUI(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(doneButton)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func dismissViewController(){
        dismiss(animated: true, completion: nil)
    }
}
