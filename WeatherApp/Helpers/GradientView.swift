//
//  GradientView.swift
//  WeatherApp
//
//  Created by Josip Marković on 11/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

import Foundation
import UIKit

//Class for creating background gradient
class GradientView: UIView {
    
    var gradient: CAGradientLayer = [GradientColors().dayColorTop, GradientColors().dayColorBottom].gradient()
    
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI(){
        self.gradient.frame = self.bounds
        self.layer.insertSublayer(self.gradient, at: 0)
    }
}
