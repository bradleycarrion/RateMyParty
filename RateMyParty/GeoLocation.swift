//
//  GeoLocation.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/12/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit
import CoreLocation

class GeoLocation: NSObject {
    
    class func addressToLocation(address:String, closure:(location:CLLocation, error:NSError?) -> ()){
        var latitude:Double  = 0
        var longitude:Double = 0
        
        let nsAddress = address as NSString
        //format the addres just%like%this
        let escAdr  = nsAddress.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //url to http request
        let urlPath = "http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@"
        //the url appended with the address
        let req = NSString(format: urlPath, escAdr!)
        let URL = NSURL(string: req as! String)
        
        let request = NSURLRequest(URL: URL!)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        
        //var jsonData:NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)!
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            var errorJson:NSError?
            let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorJson) as! NSDictionary
            if let resultsDict = jsonDict.valueForKey("results") as? NSArray {
                if let geometryDict = resultsDict.valueForKey("geometry") as? NSArray {
                    if let locDict = geometryDict.valueForKey("location") as? NSArray {
                        
                        let latArray = locDict.valueForKey("lat") as! NSArray
                        latitude = latArray.lastObject as! Double
                        
                        let lngArray = locDict.valueForKey("lng") as! NSArray
                        longitude = lngArray.lastObject as! Double
                        let loc = CLLocation(latitude: latitude, longitude: longitude)
                        closure(location: loc, error: error)
                    }
                }
            }
        }
    }
}
