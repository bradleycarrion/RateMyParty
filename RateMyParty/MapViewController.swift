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


class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var mapView:MKMapView?
    let manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var span =   MKCoordinateSpan(latitudeDelta:  0.04, longitudeDelta: 0.04)
        var region = MKCoordinateRegion(center:  manager.location.coordinate, span: span)
        mapView!.setRegion(region, animated: false)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addNewParty(sender: UIButton) {
        let newPartyLoctation = MKPointAnnotation()
        newPartyLoctation.coordinate = mapView!.centerCoordinate
        newPartyLoctation.title = "New Party"
        newPartyLoctation.subtitle = "Safety: unsure"
        mapView!.addAnnotation(newPartyLoctation)
        
    }

}
