//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift


class SearchScreenViewModel{
    
    let placeRepository: PlaceNameRepository
    let subscribeScheduler: SchedulerType
    
    
    init(placeRepository: PlaceNameRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.placeRepository = placeRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
    
    
}
