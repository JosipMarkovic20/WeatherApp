//
//  SettingsScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift


class SettingsScreenViewModel{
    
    let subscribeScheduler: SchedulerType

    
    init(subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.subscribeScheduler = subscribeScheduler
    }
    
}
