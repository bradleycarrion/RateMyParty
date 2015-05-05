//
//  HouseItem.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit
import CoreLocation

class HouseItem: NSObject {
    let loc:      CLLocation
    let address:  String
    let nickname: String
    
    init(loc: CLLocation, address: String, nickname: String) {
        self.address = address
        self.loc = loc
        self.nickname = nickname
        super.init()
    }
   
}
