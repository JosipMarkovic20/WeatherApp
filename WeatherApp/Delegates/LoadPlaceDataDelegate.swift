//
//  LoadPlaceDataDelegate.swift
//  WeatherApp
//
//  Created by Josip Marković on 13/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation


protocol LoadPlaceDataDelegate: class {
    func loadPlace(place: Place)
}
