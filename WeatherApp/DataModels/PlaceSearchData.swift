//
//  PlaceSearchData.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation


struct PlaceData: Decodable{
    let postalCodes: [Place]
}

struct Place: Decodable{
    let placeName: String
    let lng: Double
    let lat: Double
    let countryCode: String
}
