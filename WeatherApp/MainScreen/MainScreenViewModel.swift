//
//  MainScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class MainScreenViewModel: MainScreenViewModelProtocol{
    
    
    var weatherResponse: Weather?
    var weatherRepository: WeatherRepository
    var subscribeScheduler: SchedulerType
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var getWeatherDataSubject = ReplaySubject<[Double]>.create(bufferSize: 1)
    var setupScreenSubject = PublishSubject<LayoutSetupEnum>()
    let database = RealmManager()
    var settings = SettingsData()
    let loadSettingsSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    let settingsLoadedSubject = PublishSubject<Bool>()
    
    
    init(weatherRepository: WeatherRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.weatherRepository = weatherRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
    
    func collectAndPrepareData(for subject: ReplaySubject<[Double]>) -> Disposable{
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
    
    func loadSettings(for subject: ReplaySubject<Bool>) -> Disposable{
        
        return subject.flatMap({[unowned self] (bool) -> Observable<Results<RealmSettings>> in
            let settings = self.database.getSettings()
            return Observable.just(settings)
        })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({[unowned self] (results) -> SettingsData in
                return self.createSettingsObject(results: results)
            }).subscribe(onNext: {[unowned self] (settings) in
                self.settings = settings
                self.settingsLoadedSubject.onNext(true)
            })
    }
    
    func createSettingsObject(results: Results<RealmSettings>) -> SettingsData{
        let settingsData = SettingsData()
        for settingsResult in results{
            settingsData.humidityIsHidden = settingsResult.humidityIsHidden
            settingsData.pressureIsHidden = settingsResult.pressureIsHidden
            settingsData.windIsHidden = settingsResult.windIsHidden
            if settingsResult.unitsType == "Metric"{
                settingsData.unitsType = .metric
            }else{
                settingsData.unitsType = .imperial
            }
        }
        return settingsData
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
    
    
    func findMinAndMaxTemperatures() -> (min: Double,max: Double){
        let currentTime = weatherResponse?.currently.time ?? 0
        guard let possibleTimes = weatherResponse?.daily.data else { return (0,0)}
        
        for daily in possibleTimes{
            let time = daily.time
            let possibleDate = convertUnixTimeToDate(unixTime: time)
            let currentDate = convertUnixTimeToDate(unixTime: currentTime)
            if possibleDate == currentDate{
                return (daily.temperatureMin, daily.temperatureMax)
            }
        }
        return (0,0)
    }
 
    
    func convertUnixTimeToDate(unixTime: Int) -> String{
        let date = Date(timeIntervalSince1970: Double(unixTime))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}


protocol MainScreenViewModelProtocol{
    
    var weatherResponse: Weather? {get set}
    var getWeatherDataSubject: ReplaySubject<[Double]> {get set}
    var loaderSubject: ReplaySubject<Bool> {get set}
    
    func collectAndPrepareData(for subject: ReplaySubject<[Double]>) -> Disposable
}
