//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift


class SearchScreenViewModel: SearchScreenProtocol{
    
    var placeResponse: [Place] = []
    var getPlaceDataSubject = PublishSubject<String>()
    let placeRepository: PlaceNameRepository
    let subscribeScheduler: SchedulerType
    let tableReloadSubject = PublishSubject<Bool>()
    
    init(placeRepository: PlaceNameRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.placeRepository = placeRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
    func collectAndPrepareData(for subject: PublishSubject<String>) -> Disposable {
        return subject.flatMap({ (query) -> Observable<PlaceData> in
            return self.placeRepository.getPlace(name: query)
        })
            .map({ (placeData) -> [Place] in
                self.placeResponse.removeAll()
                return placeData.postalCodes
            }).subscribe(onNext: { (places) in
                self.placeResponse = places
                self.tableReloadSubject.onNext(true)
            })
    }

}


protocol SearchScreenProtocol {
    
    var placeResponse: [Place] {get set}
    var getPlaceDataSubject: PublishSubject<String> {get set}
    
    func collectAndPrepareData(for subject: PublishSubject<String>) -> Disposable
}
