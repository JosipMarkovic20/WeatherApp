//
//  PlaceSearchData.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Structs for determining which data we want to parse from json response for locations
struct PlaceData: Decodable{
    let geonames: [Place]
}

struct Place: Decodable{
    let name: String
    let lng: String
    let lat: String
    let geonameId: Int
}
