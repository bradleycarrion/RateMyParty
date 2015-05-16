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


class MapViewController: UIViewController, CLLocationManagerDelegate, AddHouseDelegate, MKMapViewDelegate {
    @IBOutlet var mapView:MKMapView?
    let manager = CLLocationManager()
    var pins = [HouseItem]()
<<<<<<< HEAD
=======
    
    // creates a white background to better see the time and power
    let timePowerBar = UIView()
>>>>>>> origin/master
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.delegate = self
        
        timePowerBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
        timePowerBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(timePowerBar)
        
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.blackColor()
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
<<<<<<< HEAD
        }
=======
        } else if (segue.identifier == "discussionSegue") {
            let addVc = segue.destinationViewController as! DiscussionViewController
        } else {
            let addVc = segue.destinationViewController as! ViewController
        }
            
        /**
         * Bert -> to list segue (implement later)
>>>>>>> origin/master
        else if (segue.identifier == "maptolist") {
            println("list view controller")
            let listVc = segue.destinationViewController as! HouseTableViewController
            listVc.pins = self.pins
        }
<<<<<<< HEAD
=======
        */
>>>>>>> origin/master
    }
    
    
    /**
      * add house delegate method 
      * used to add pins to the map
      */
    
    func addPin(adress: String, nickName: String) {
        let pin = MKPointAnnotation()
        GeoLocation.addressToLocation(adress) { (location, error) in
            if (error == nil) {
                pin.coordinate = location.coordinate
                pin.title = nickName
                pin.subtitle = adress
                self.mapView?.addAnnotation(pin)
                let pinDb = PinDatabase()
                pinDb.addPinToDatabase(location, address: adress, nickname: nickName) {}
            }
            else {
                println("JSON ERROR")
            }
        }
        
    }
    
    
    /** 
      * gets all pins within a certain radius and displays them to the map
      */
    private func getLocalPins() {
        let pinDb = PinDatabase()
<<<<<<< HEAD
        pinDb.fetchPins(manager.location, radiusInMeters: 10000) { (results) in
=======
        pinDb.fetchPins(manager.location, radiusInMeters: 100000000) { (results) in
>>>>>>> origin/master
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
    
    // When user taps on the disclosure button you can perform a segue to navigate to another view controller
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView{
            println(view.annotation.title) // annotation's title
            println(view.annotation.subtitle) // annotation's subttitle
            
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
            performSegueWithIdentifier("discussionSegue", sender: nil)
        }
    }
    
    // Here we add disclosure button inside annotation window
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton // button with info sign in it
        
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }

}
