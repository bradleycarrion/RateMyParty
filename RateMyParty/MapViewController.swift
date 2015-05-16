//
//  MapViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate, AddHouseDelegate{
    @IBOutlet var mapView:MKMapView?
    let manager = CLLocationManager()
    var pins = [HouseItem]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var span =   MKCoordinateSpan(latitudeDelta:  0.04, longitudeDelta: 0.04)
        var region = MKCoordinateRegion(center:  manager.location.coordinate, span: span)
        mapView!.setRegion(region, animated: false)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.getLocalPins()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // gets the incoming view controller and sets the delegate to self
        if (segue.identifier == "addpin") {
            let addVc = segue.destinationViewController as! AddHouseViewController
            addVc.delegate = self
        }
        else if (segue.identifier == "maptolist") {
            println("list view controller")
            let listVc = segue.destinationViewController as! HouseTableViewController
            listVc.pins = self.pins
        }
    }
    
    
    /**
      * add house delegate method 
      * used to add pins to the map
      */
    
    func addPin(adress: String, nickName: String) {
        println("pin at \(adress)")
        let pin = MKPointAnnotation()
        pin.coordinate = manager.location.coordinate
        pin.title = nickName
        pin.subtitle = adress
        mapView?.addAnnotation(pin)
        let pinDb = PinDatabase()
        pinDb.addPinToDatabase(manager.location, address: adress, nickname: nickName) {}
    }
    
    
    /** 
      * gets all pins within a certain radius and displays them to the map
      */
    private func getLocalPins() {
        let pinDb = PinDatabase()
        pinDb.fetchPins(manager.location, radiusInMeters: 10000) { (results) in
            if let finds = results {
                for r in finds {
                    let adr = r.objectForKey("address") as! String
                    let nickname = r.objectForKey("nickname") as! String
                    let loc = r.objectForKey("location") as! CLLocation
                    let pin = MKPointAnnotation()
                    pin.coordinate = loc.coordinate
                    pin.title = nickname
                    pin.subtitle = adr
                    self.mapView?.addAnnotation(pin)
                    let houseItem = HouseItem(loc: loc, address: adr, nickname: nickname)
                    self.pins.append(houseItem)
                }
                
                
            }
        }
    }

}
