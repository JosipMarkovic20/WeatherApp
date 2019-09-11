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
    var getWeatherDataSubject = PublishSubject<[Double]>()
    
    
    init(weatherRepository: WeatherRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.weatherRepository = weatherRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
    
    func collectAndPrepareData(for subject: PublishSubject<[Double]>) -> Disposable{
        
        return subject.flatMap({[unowned self] (locationArray) -> Observable<Weather> in
            self.loaderSubject.onNext(true)
            return self.weatherRepository.getWeather(lng: locationArray[0], lat: locationArray[1])
        })
            .observeOn(MainScheduler.instance)
            .subscribeOn(subscribeScheduler)
            .subscribe(onNext: {[unowned self] (weather) in
                self.weatherResponse = weather
                self.loaderSubject.onNext(false)
            }, onError: { (error) in
                self.loaderSubject.onNext(false)
                print(error)
            })
        
    }
    
}


protocol MainScreenViewModelProtocol{
    
    var weatherResponse: Weather? {get set}
    var getWeatherDataSubject: PublishSubject<[Double]> {get set}
    var loaderSubject: ReplaySubject<Bool> {get set}
    
    func collectAndPrepareData(for subject: PublishSubject<[Double]>) -> Disposable
}
