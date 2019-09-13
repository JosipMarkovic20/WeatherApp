//
//  MainScreenCoordinator.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class MainScreenCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    let viewModel: MainScreenViewModel
    let viewController: MainScreenViewController
    

    init(){
        viewModel = MainScreenViewModel(weatherRepository: WeatherRepository())
        viewController = MainScreenViewController(viewModel: viewModel)
    }
    
    func start() {
        openSearch()
    }
    
    func openSearch(){
        self.viewController.openSearchScreen = {[unowned self] in
            let coordinator = SearchScreenCoordinator(mainViewController: self.viewController)
            self.store(coordinator: coordinator)
            coordinator.viewController.coordinatorDelegate = self
            coordinator.start()
        }
    }
    
}


extension MainScreenCoordinator: ParentCoordinatorDelegate, CoordinatorDelegate{
    
    
    func childHasFinished(coordinator: Coordinator) {
        free(coordinator: coordinator)
    }
    
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        childHasFinished(coordinator: self)
    }
    
}

