//
//  MainScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift


class MainScreenViewModel: MainScreenViewModelProtocol{
    
    
    var weatherResponse: Weather?
    var weatherRepository: WeatherRepository
    var subscribeScheduler: SchedulerType
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    
    init(weatherRepository: WeatherRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.weatherRepository = weatherRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
}


protocol MainScreenViewModelProtocol{
    
    var weatherResponse: Weather? {get set}
}
