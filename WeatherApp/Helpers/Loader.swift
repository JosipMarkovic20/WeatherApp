//
//  Loader.swift
//  WeatherApp
//
//  Created by Josip Marković on 11/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit


//Class for creating loader which is shown while fetching data
class LoaderViewController: UIViewController {
    var loader  = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        view.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
