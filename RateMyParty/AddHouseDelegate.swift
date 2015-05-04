//
//  AddHouseDelegate.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/3/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import MapKit

protocol AddHouseDelegate {
    
    /**
        this function is to be called when transitioning from AddHouseScreen back to MapViewController
        It is to be implemented to drop a pin with the coodinate and name
     **/
    func addPinToMap(coord: CLLocationCoordinate2D, houseName: String)
    
}
