//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class SearchScreenViewModel: SearchScreenProtocol{
    
    var placeResponse: [Place] = []
    var getPlaceDataSubject = PublishSubject<String>()
    let placeRepository: PlaceNameRepository
    let subscribeScheduler: SchedulerType
    let tableReloadSubject = PublishSubject<Bool>()
    let database = RealmManager()
    let saveLocationSubject = PublishSubject<Place>()
    
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
    
    func saveLocation(for subject: PublishSubject<Place>) -> Disposable{
        
        return subject.flatMap({[unowned self] (place) -> Observable<String> in
            return self.database.saveLocation(location: place)
        })
            .observeOn(MainScheduler.instance)
            .subscribeOn(subscribeScheduler)
            .subscribe(onNext: { (string) in
                print(string)
            })
    }
    

}


protocol SearchScreenProtocol {
    
    var placeResponse: [Place] {get set}
    var getPlaceDataSubject: PublishSubject<String> {get set}
    
    func collectAndPrepareData(for subject: PublishSubject<String>) -> Disposable
}
