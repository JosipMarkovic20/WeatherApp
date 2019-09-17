//
//  SettingsScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class SettingsScreenViewModel{
    
    let subscribeScheduler: SchedulerType
    let database = RealmManager()
    var settings = SettingsData()
    let loadSettingsSubject = PublishSubject<Bool>()
    let settingsLoadedSubject = PublishSubject<Bool>()
    var locations: Results<RealmLocation>?
    let loadLocationsSubject = PublishSubject<Bool>()
    let tableReloadSubject = PublishSubject<Bool>()
    let deleteLocationSubject = PublishSubject<Int>()
    let locationsLoadedSubject = PublishSubject<Bool>()

    
    init(subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.subscribeScheduler = subscribeScheduler
    }
    
    func loadSettings(for subject: PublishSubject<Bool>) -> Disposable{
        
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
    
    func loadLocations(for subject: PublishSubject<Bool>) -> Disposable{
        
        return subject.flatMap({[unowned self] (bool) -> Observable<Results<RealmLocation>> in
            let locations = self.database.getLocations()
            return Observable.just(locations)
        })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({(results) -> Results<RealmLocation> in
                return results
            })
            .subscribe(onNext: {[unowned self] (locations) in
                self.locations = locations
                self.tableReloadSubject.onNext(true)
                self.locationsLoadedSubject.onNext(true)
            })
    }
    
    func createLocationsArray(results: Results<RealmLocation>) -> [Place]{
        var locations: [Place] = []
        for location in results{
            let place = Place(name: location.name, lng: location.lng, lat: location.lat, geonameId: location.geonameId, countryCode: location.countryCode)
            locations.append(place)
        }
        return locations
    }
    
    func deleteLocation(for subject: PublishSubject<Int>) -> Disposable{
        
        return subject
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({[unowned self] (place) -> Observable<String> in
                let result = self.database.deleteLocation(geonameId: place)
                return result
            }).subscribe(onNext: { (string) in
                print(string)
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
    
    
    
    
}
