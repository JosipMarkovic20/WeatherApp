//
//  MainScreenData.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation


struct Weather: Decodable{
    let currently: [Currently]
    let daily: [Daily]
}

struct Currently: Decodable{
    let humidity: Double
    let icon: String
    let pressure: Double
    let temperature: Double
    let time: Int
    let windSpeed: Double
    let summary: String
}


struct Daily: Decodable{
    let temperatureMin: Double
    let temperatureMax: Double
    let time: Int
}
