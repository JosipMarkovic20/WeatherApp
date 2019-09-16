//
//  SettingsDelegate.swift
//  WeatherApp
//
//  Created by Josip Marković on 16/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation


protocol SettingsDelegate: class {
    func setupBasedOnSettings(settings: SettingsData)
}
