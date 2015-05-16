//
//  MapViewDelegate.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/15/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapViewDelegate {
    
    func setLocationForHouse(location: CLLocation)
    
}
