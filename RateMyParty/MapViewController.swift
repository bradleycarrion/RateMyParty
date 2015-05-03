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

class MapViewController: UIViewController {
    @IBOutlet var mapView:MKMapView?
    let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 47.6772330,
        longitude: -117.4028770)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 2
        let span = MKCoordinateSpanMake(0.04, 0.04)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView!.setRegion(region, animated: true)
        
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