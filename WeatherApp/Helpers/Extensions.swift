//
//  Extensions.swift
//  WeatherApp
//
//  Created by Josip Marković on 11/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation



extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
