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
    let popUpSubject = PublishSubject<Bool>()
    
    init(placeRepository: PlaceNameRepository, subscribeScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)){
        self.placeRepository = placeRepository
        self.subscribeScheduler = subscribeScheduler
    }
    
    func collectAndPrepareData(for subject: PublishSubject<String>) -> Disposable {
        return subject.flatMap({[unowned self] (query) -> Observable<PlaceData> in
            return self.placeRepository.getPlace(name: query)
        })
            .observeOn(MainScheduler.instance)
            .subscribeOn(subscribeScheduler)
            .map({[unowned self] (placeData) -> [Place] in
                self.placeResponse.removeAll()
                return placeData.geonames
            }).subscribe(onNext: {[unowned self] (places) in
                self.placeResponse = places
                self.tableReloadSubject.onNext(true)
            }, onError: {[unowned self] (error) in
                self.popUpSubject.onNext(true)
                print(error)
            })
    }
    
    func saveLocation(for subject: PublishSubject<Place>) -> Disposable{
        
        return subject.flatMap({[unowned self] (place) -> Observable<String> in
            guard let location = self.database.realm?.object(ofType: RealmLocation.self, forPrimaryKey: place.geonameId) else{
                print(self.database.deleteLastLocation())
                print(self.database.saveLastLocation(location: place))
                return self.database.saveLocation(location: place)
            }
            return Observable.just("\(location.name) already saved in database")
        })
            .observeOn(MainScheduler.instance)
            .subscribeOn(subscribeScheduler)
            .subscribe(onNext: { (string) in
                print(string)
            }, onError: {[unowned self] (error) in
                self.popUpSubject.onNext(true)
                print(error)
            })
    }
    
    
}


protocol SearchScreenProtocol {
    
    var placeResponse: [Place] {get set}
    var getPlaceDataSubject: PublishSubject<String> {get set}
    
    func collectAndPrepareData(for subject: PublishSubject<String>) -> Disposable
}
