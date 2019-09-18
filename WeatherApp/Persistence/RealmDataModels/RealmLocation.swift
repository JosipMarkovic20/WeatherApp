//
//  RealmWeather.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RealmSwift

//Class that defines all parameters we want to store to realm for location object
class RealmLocation: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var lng: String = ""
    @objc dynamic var lat: String = ""
    @objc dynamic var geonameId: Int = 0
    
    func createRealmLocation(location: Place){
        self.name = location.name
        self.lng = location.lng
        self.lat = location.lat
        self.geonameId = location.geonameId
    }
    
    override class func primaryKey() -> String?{
        return "geonameId"
    }
}


