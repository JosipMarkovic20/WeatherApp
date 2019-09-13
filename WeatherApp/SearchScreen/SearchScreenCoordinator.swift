//
//  SearchScreenCoordinator.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit




class SearchScreenCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    let viewModel: SearchScreenViewModel
    let viewController: SearchScreenViewController
    let mainViewController: MainScreenViewController
    
    init(mainViewController: MainScreenViewController){
        self.viewModel = SearchScreenViewModel(placeRepository: PlaceNameRepository())
        self.viewController = SearchScreenViewController(viewModel: viewModel)
        self.mainViewController = mainViewController
    }
    
    deinit {
        print("deinit: \(self)")
    }


    func start() {
        viewController.modalPresentationStyle = .overCurrentContext
        mainViewController.present(viewController, animated: false)
    }
}


