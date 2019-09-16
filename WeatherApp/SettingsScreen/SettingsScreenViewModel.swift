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
            }).subscribe(onNext: { (settings) in
                self.settings = settings
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
