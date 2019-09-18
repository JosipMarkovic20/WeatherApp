//
//  RealmSettings.swift
//  WeatherApp
//
//  Created by Josip Marković on 18/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RealmSwift


//Class that defines all parameters we want to store to realm for settings object
class RealmSettings: Object{
    @objc dynamic var unitsType: String = "Metric"
    @objc dynamic var windIsHidden: Bool = false
    @objc dynamic var humidityIsHidden: Bool = false
    @objc dynamic var pressureIsHidden: Bool = false
    
    func createRealmSettings(settings: SettingsData){
        self.windIsHidden = settings.windIsHidden
        self.humidityIsHidden = settings.humidityIsHidden
        self.pressureIsHidden = settings.pressureIsHidden
        if settings.unitsType == .metric{
            self.unitsType = "Metric"
        }else{
            self.unitsType = "Imperial"
        }
    }
}
