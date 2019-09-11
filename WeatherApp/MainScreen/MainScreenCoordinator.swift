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
    let viewController = MainScreenViewController()
    

    
    func start() {
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
