//
//  SettingsData.swift
//  WeatherApp
//
//  Created by Josip Marković on 16/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Class for creating settings object
class SettingsData{
    
    var unitsType: UnitsTypeEnum
    var windIsHidden: Bool
    var humidityIsHidden: Bool
    var pressureIsHidden: Bool
    
    init(unitsType: UnitsTypeEnum = .metric, windIsHidden: Bool = false, humidityIsHidden: Bool = false, pressureIsHidden: Bool = false) {
        self.unitsType = unitsType
        self.windIsHidden = windIsHidden
        self.humidityIsHidden = humidityIsHidden
        self.pressureIsHidden = pressureIsHidden
    }
}
