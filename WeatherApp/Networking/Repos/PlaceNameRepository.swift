//
//  PlaceNameRepository.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


//Repository that contains routes for location
class PlaceNameRepository{
    
    let alamofire = AlamofireManager()
    
    func getPlace(name: String) -> Observable<PlaceData>{
        let placeURL = "http://api.geonames.org/searchJSON?q=" + "\(name)&maxRows=20&username=jmarkovic"
        return alamofire.getPlaceAlamofireWay(jsonUrlString: placeURL)
    }
}
