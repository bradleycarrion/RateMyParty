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
    // Outlet to the main MapView
    @IBOutlet var mapView:MKMapView?
    // handles the user's location
    let manager = CLLocationManager()
    // holds all of the pins
    var pins = [HouseItem]()
    // creates a white background to better see the time, battery, and service
    let timePowerBar = UIView()
    
    var delegate: MapViewDelegate?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.requestAlwaysAuthorization()
        mapView?.delegate = self
        mapView?.showsUserLocation = true
        
        /*
        * This is a UIView that is meant to better display the user's
        * service, battery percentage, and the time
        */
        timePowerBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
        timePowerBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(timePowerBar)
        
        
        UITabBar.appearance().barTintColor = UIColor.blackColor() // TabBar Color : black
        self.view.backgroundColor = UIColor.blackColor() // Background Color : black
        
        var span =   MKCoordinateSpan(latitudeDelta:  0.04, longitudeDelta: 0.04) // Initial view span
        var region = MKCoordinateRegion(center:  manager.location.coordinate, span: span) // Initial region
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
            // case: when the addHouse button is pressed
            let addVc = segue.destinationViewController as! AddHouseViewController
            addVc.delegate = self
        } else if (segue.identifier == "discussionSegue") {
            // case: when the info button is pressed on any annotation
            let addVc = segue.destinationViewController as! DiscussionViewController
        } else {
            // case: ... ?
            let addVc = segue.destinationViewController as! ViewController
        }
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
        pinDb.fetchPins(manager.location, radiusInMeters: 150000000) { (results) in
            if let finds = results {
                for r in finds {
                    let adr = r.objectForKey("address") as! String
                    let nickname = r.objectForKey("nickname") as! String
                    let loc = r.objectForKey("location") as! CLLocation
                    let pin = MKPointAnnotation()
                    pin.coordinate = loc.coordinate
                    pin.title = nickname
                    var distance = Int(loc.distanceFromLocation(self.manager.location) * 0.000621371)
                    pin.subtitle = String(stringInterpolationSegment: distance) + " miles"
                    //pin.subtitle = adr
                    self.mapView?.addAnnotation(pin)
                    let houseItem = HouseItem(loc: loc, address: adr, nickname: nickname)
                    self.pins.append(houseItem)
                }
            }
        }
    }
    
    /* 
    * When user taps on the disclosure button
    * you can perform a segue to navigate to the
    * discussion view controller
    */
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView{
            println(view.annotation.title) // title
            println(view.annotation.subtitle) // subtitle
            
            // Segue to the discussion page when the button is pressed
            performSegueWithIdentifier("discussionSegue", sender: nil)
        }
    }
    
    /*
    * Adding the disclosure button to the
    * mapView annotations
    */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            // changing the color of the pins
            pinView?.pinColor = MKPinAnnotationColor.Green
        }
        
        // creates the information button within the annotation
        var button = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        pinView?.rightCalloutAccessoryView = button
        pinView?.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "house.jpg"))
        
        return pinView
    }

}
