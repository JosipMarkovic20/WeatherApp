//
//  SettingsScreenCoordinator.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class SettingsScreenCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    let viewModel: SettingsScreenViewModel
    let viewController: SettingsScreenViewController
    let mainViewController: MainScreenViewController
    
    init(mainViewController: MainScreenViewController){
        self.viewModel = SettingsScreenViewModel()
        self.viewController = SettingsScreenViewController(viewModel: viewModel)
        self.mainViewController = mainViewController
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    
    func start() {
        viewController.modalPresentationStyle = .overCurrentContext
        mainViewController.present(viewController, animated: true)
    }
    
}
