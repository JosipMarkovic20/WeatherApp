//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    var window: UIWindow
    var mainScreenCoordinator: MainScreenCoordinator?
    
    
    init(window: UIWindow){
        self.window = window
    }
    
    
    func start() {
        self.mainScreenCoordinator = MainScreenCoordinator()
        window.rootViewController = mainScreenCoordinator?.viewController
        window.makeKeyAndVisible()
        
        guard let mainScreenCoordinator = self.mainScreenCoordinator else { return }
        self.store(coordinator: mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
}
