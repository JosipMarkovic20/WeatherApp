//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift


class RealmManager {
    
    let realm = try? Realm()
    
    //Deleting specific location from realm
    func deleteLocation(geonameId: Int) -> Observable<String>{
        guard let realmLocation = self.realm?.object(ofType: RealmLocation.self, forPrimaryKey: geonameId) else { return Observable.just("Object not found!")}
        
        do{
            try self.realm?.write {
                self.realm?.delete(realmLocation)
            }
        }catch{
            return Observable.just("Error deleting object!")
        }
        return Observable.just("Object deleted!")
    }
    
    //Saving specific location to realm
    func saveLocation(location: Place) -> Observable<String>{
        let realmLocation = RealmLocation()
        realmLocation.createRealmLocation(location: location)
        do{
            try realm?.write {
                realm?.add(realmLocation)
            }
        }catch{
            return Observable.just("Error saving object!")
        }
        return Observable.just("Object saved!")
    }
    
    //Saving last viewed location to realm
    func saveLastLocation(location: Place) -> Observable<String>{
        let realmLocation = LastRealmLocation()
        realmLocation.createRealmLocation(location: location)
        do{
            try realm?.write {
                realm?.add(realmLocation)
            }
        }catch{
            return Observable.just("Error saving object!")
        }
        return Observable.just("Object saved!")
    }
    
    //Deleting last viewd location from realm
    func deleteLastLocation() -> Observable<String>{
        let backThreadRealm = try? Realm()
        guard let allLastLocations = backThreadRealm?.objects(LastRealmLocation.self) else { return Observable.just("Object not found!") }
        do{
            try backThreadRealm?.write {
                backThreadRealm?.delete(allLastLocations)
            }
        }catch{
            return Observable.just("Error deleting settings!")
        }
        return Observable.just("Settings deleted!")
    }
    
    //Fetching last viewed location from realm
    func getLastLocation() -> Results<LastRealmLocation>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(LastRealmLocation.self)
    }
    
    //Fetching all previous locations from realm
    func getLocations() -> Results<RealmLocation>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(RealmLocation.self)
    }
    
    
    //Deleting settings objects from realm
    func deleteSettings() -> Observable<String>{
        let backThreadRealm = try? Realm()
        guard let allSettingsObjects = backThreadRealm?.objects(RealmSettings.self) else { return Observable.just("Object not found!") }
        do{
            try backThreadRealm?.write {
                backThreadRealm?.delete(allSettingsObjects)
            }
        }catch{
            return Observable.just("Error deleting settings!")
        }
        return Observable.just("Settings deleted!")
    }
    
    
    //Saving settings object to realm
    func saveSettings(settings: SettingsData) -> Observable<String>{
        let backThreadRealm = try? Realm()
        let settingsToSave = RealmSettings()
        settingsToSave.createRealmSettings(settings: settings)
        do{
            try backThreadRealm?.write {
                backThreadRealm?.add(settingsToSave)
            }
        }catch{
            return Observable.just("Error saving settings!")
        }
        return Observable.just("Settings saved!")
    }
    
    
    //Fetching settings object from realm
    func getSettings() -> Results<RealmSettings>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(RealmSettings.self)
    }
    
}
