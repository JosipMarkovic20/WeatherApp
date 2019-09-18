//
//  CoordinatorDelegates.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Delegate for removing coordinates from memory
protocol ParentCoordinatorDelegate {
    func childHasFinished(coordinator: Coordinator)
}

protocol CoordinatorDelegate: class {
    func viewControllerHasFinished()
}
