//
//  AlamofireManager.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AlamofireManager{
    let jsonDecoder = JSONDecoder()
    
    //Makes request for weather and parses json response
    func getWeatherAlamofireWay(jsonUrlString: String) -> Observable<Weather>{
        
        return Observable.create{observer in
            Alamofire.request(jsonUrlString)
                .validate()
                .responseJSON {[unowned self] response in
                    do{
                        guard let data = response.data else { return }
                        let weatherResponse = try self.jsonDecoder.decode(Weather.self, from: data)
                        observer.onNext(weatherResponse)
                        observer.onCompleted()
                    } catch let jsonErr{
                        print("Error parsing json: ",jsonErr)
                        observer.onError(jsonErr)
                    }
            }
            return Disposables.create {
                Alamofire.request(jsonUrlString).cancel()
            }
        }
    }
    
    
    //Makes request for location and parses json response
    func getPlaceAlamofireWay(jsonUrlString: String) -> Observable<PlaceData>{
        let encodedString = jsonUrlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        return Observable.create{observer in
            Alamofire.request(encodedString)
                .validate()
                .responseJSON {[unowned self] response in
                    do{
                        guard let data = response.data else { return }
                        let placeResponse = try self.jsonDecoder.decode(PlaceData.self, from: data)
                        observer.onNext(placeResponse)
                        observer.onCompleted()
                    } catch let jsonErr{
                        print("Error parsing json: ",jsonErr)
                        observer.onError(jsonErr)
                    }
            }
            return Disposables.create {
                Alamofire.request(jsonUrlString).cancel()
            }
        }
    }
    
    
}
