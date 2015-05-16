//
//  PinDatabase.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit
import CoreLocation
import CloudKit

class PinDatabase: NSObject {
    
    override init() {}

    /**
      * takes a location and an adress and it adds it to the database
      */
    func addPinToDatabase(location: CLLocation, address: String, nickname: String, closure: () -> ()) {
        let pinRecord = CKRecord(recordType: "House")
        pinRecord.setObject(location, forKey:"location")
        pinRecord.setObject(address, forKey: "address")
        pinRecord.setObject(nickname, forKey: "nickname")
        
        TopCloud.pushToCloud(pinRecord, closure: closure)
    }
    
    
    /**
      * Retreives the pins within the pin radius
      * returns pins as an array[AnyObject] in closure
      */
    func fetchPins(centerLocation:CLLocation, radiusInMeters:CLLocationDistance, closure: (results:[AnyObject]?) -> ()) {
        let radiusInKm = radiusInMeters/1000
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(%K,%@) < %f","location",centerLocation,radiusInKm)
        let query = CKQuery(recordType: "House", predicate: predicate)
        TopCloud.getQueryResults(query, closure: closure)
    }
    
   
}
