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
    
    func getLastLocation() -> Results<LastRealmLocation>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(LastRealmLocation.self)
    }
    
    
    func getLocations() -> Results<RealmLocation>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(RealmLocation.self)
    }
    
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
    
    func getSettings() -> Results<RealmSettings>{
        let backThreadRealm = try! Realm()
        return backThreadRealm.objects(RealmSettings.self)
    }
    
}
