//
//  DeleteLocationDelegate.swift
//  WeatherApp
//
//  Created by Josip Marković on 17/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Delegate for deleting location from database
protocol DeleteLocationDelegate: class {
    func deleteLocation(geonameId: Int)
}
