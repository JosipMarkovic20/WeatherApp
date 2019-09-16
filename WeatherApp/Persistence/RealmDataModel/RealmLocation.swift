//
//  RealmWeather.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RealmSwift


class RealmLocation: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var lng: Double = 0
    @objc dynamic var lat: Double = 0
    @objc dynamic var countryCode: String = ""
    
    func createRealmLocation(location: Place){
        self.name = location.placeName
        self.lng = location.lng
        self.lat = location.lat
        self.countryCode = location.countryCode
    }
    
    override class func primaryKey() -> String?{
        return "name"
    }
}

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