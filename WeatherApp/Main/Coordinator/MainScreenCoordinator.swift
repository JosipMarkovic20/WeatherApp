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
        setupSearchOpening()
        setupSettingsOpening()
    }
    
    
    //Setting commands for opening search screen when search bar is clicked
    func setupSearchOpening(){
        self.viewController.screenView.openSearchScreen = {[unowned self] in
            let coordinator = SearchScreenCoordinator(mainViewController: self.viewController)
            self.store(coordinator: coordinator)
            coordinator.viewController.coordinatorDelegate = self
            coordinator.viewController.loadPlaceDelegate = self
            coordinator.start()
        }
    }
    
    //Setting commands for opening settings screen when settings icon is clicked
    func setupSettingsOpening(){
        self.viewController.openSettingsScreen = {[unowned self] in
            let coordinator = SettingsScreenCoordinator(mainViewController: self.viewController)
            self.store(coordinator: coordinator)
            coordinator.viewController.coordinatorDelegate = self
            coordinator.viewController.settingsDelegate = self.viewController
            coordinator.viewController.loadPlaceDelegate = self
            coordinator.start()
        }
    }
    
}


extension MainScreenCoordinator: ParentCoordinatorDelegate, CoordinatorDelegate, LoadPlaceDataDelegate{
    
    
    func loadPlace(place: Place) {
        guard let longitude = Double(place.lng) else { return }
        guard let lattitude = Double(place.lat) else { return }
        viewModel.lastPlaceCoordinates = [longitude, lattitude]
        viewController.getData()
        viewModel.lastPlaceName = place.name
    }
    
    func childHasFinished(coordinator: Coordinator) {
        free(coordinator: coordinator)
    }
    
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        childHasFinished(coordinator: self)
    }
    
}
