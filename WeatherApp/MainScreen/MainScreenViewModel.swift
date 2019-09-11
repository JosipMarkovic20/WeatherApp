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
    var setupScreenSubject = PublishSubject<LayoutSetupEnum>()
    
    
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
                self.setupScreenSubject.onNext(self.checkIcon())
            }, onError: { (error) in
                self.loaderSubject.onNext(false)
                print(error)
            })
    }
    
    func checkIcon() -> LayoutSetupEnum{
        let currentIcon = weatherResponse?.currently.icon
        if currentIcon == "clear-day"{
            return .clearDay
        }else if currentIcon == "clear-night"{
            return .clearNight
        }else if currentIcon == "rain"{
            return .rain
        }else if currentIcon == "snow"{
            return .snow
        }else if currentIcon == "sleet"{
            return .sleet
        }else if currentIcon == "wind"{
            return .wind
        }else if currentIcon == "fog"{
            return .fog
        }else if currentIcon == "cloudy"{
            return .cloudy
        }else if currentIcon == "partly-cloudy-day"{
            return .partlyCloudyDay
        }else if currentIcon == "partly-cloudy-night"{
            return .partlyCloudyNight
        }else if currentIcon == "hail"{
            return .hail
        }else if currentIcon == "thunderstorm"{
            return .thunderstorm
        }else if currentIcon == "tornado"{
            return .tornado
        }
        return .clearDay
    }
    
}


protocol MainScreenViewModelProtocol{
    
    var weatherResponse: Weather? {get set}
    var getWeatherDataSubject: PublishSubject<[Double]> {get set}
    var loaderSubject: ReplaySubject<Bool> {get set}
    
    func collectAndPrepareData(for subject: PublishSubject<[Double]>) -> Disposable
}
