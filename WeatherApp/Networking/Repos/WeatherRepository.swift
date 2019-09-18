//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


//Repository that contains routes for weather
class WeatherRepository{
    
    let alamofire = AlamofireManager()
    
    func getWeather(lng: Double, lat: Double) -> Observable<Weather>{
        let weatherURL = "https://api.darksky.net/forecast/d9876cf842eb1bb73368fbaca7b084d0/" + String(lat) + ",\(String(lng))?units=si"
        return alamofire.getWeatherAlamofireWay(jsonUrlString: weatherURL)
    }
}
