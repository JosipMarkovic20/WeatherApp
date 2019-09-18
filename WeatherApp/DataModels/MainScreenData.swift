//
//  MainScreenData.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation

//Structs for determining which data we want to parse from json response for weather
struct Weather: Decodable{
    let currently: Currently
    let daily: Daily
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
    let data: [DailyData]
}

struct DailyData: Decodable{
    let temperatureMin: Double
    let temperatureMax: Double
    let time: Int
}
