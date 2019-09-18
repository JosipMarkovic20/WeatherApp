//
//  LoadPlaceDataDelegate.swift
//  WeatherApp
//
//  Created by Josip Marković on 13/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Delegate for loading place after it is selected either from search screen or settings screen
protocol LoadPlaceDataDelegate: class {
    func loadPlace(place: Place)
}
