//
//  AddHouseDelegate.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

/**
  * this protocol is to be implemented by MapViewController
  * by implementing this, Pins can be added to the map from the AddHouseViewController
  */

import UIKit

protocol AddHouseDelegate {
    
    /**
        Should be defined to add pin to a mapview
        param: adress-> address of the house to be added
        param: nickName -> the name of the house being added i.e. basketball house ...
      */
    func addPin(adress: String, nickName: String)
}
