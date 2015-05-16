//
//  MainHouseListView.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/13/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MainHouseListView: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    // the main table view to display nearby houses
    @IBOutlet var houseTableView: UITableView!
    
    // search bar for the list of houses
    @IBOutlet var searchBar:UISearchBar?
    
    // creates a white background to better see the time and power
    let timePowerBar = UIView()
    
    // Array of addresses to load into the table view
    var addressList = [String]()
    var nickNameList = [String]()
    var imageList = [UIView]()
    var houseLocations = [CLLocation]()
    
    // built in swift refresh control
    var refreshControl:UIRefreshControl!
    
    //constant for cell reuse
    let CELL_ID = "HouseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the return key to display "Search"
        searchBar?.returnKeyType = UIReturnKeyType.Search
        
        houseTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        houseTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        houseTableView.rowHeight = UITableViewAutomaticDimension
        houseTableView.estimatedRowHeight = 160.0
        houseTableView.delegate = self
        houseTableView.dataSource = self
        
        /*
        * This is a UIView that is meant to better display the user's
        * service, battery percentage, and the time
        */
        timePowerBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
        timePowerBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(timePowerBar)
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        refreshControl = UIRefreshControl()
        refreshControl.layoutIfNeeded()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        houseTableView.addSubview(refreshControl)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.displayLocalHouses()
            self.refreshControl.reloadInputViews()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellAtIndexPath(indexPath)
    }
    
    func cellAtIndexPath(indexPath:NSIndexPath) -> HouseCell {
        var cell:HouseCell = houseTableView.dequeueReusableCellWithIdentifier(CELL_ID) as! HouseCell
        self.setNameForCell(cell, indexPath: indexPath)
        //self.setAddressForCell(cell, indexPath: indexPath)
        self.setImageForCell(cell, indexPath: indexPath)
        self.setLocationForHouse(cell, indexPath: indexPath)
        
        return cell
    }
    
    func setNameForCell(cell:HouseCell, indexPath:NSIndexPath) {
        let houseName = nickNameList[indexPath.row] as String
        cell.houseNameLabel.text = houseName
    }
    /*
    func setAddressForCell(cell:HouseCell, indexPath:NSIndexPath) {
        let houseAddress = addressList[indexPath.row] as String
        cell.addressLabel.text = houseAddress
    }*/
    
    func setImageForCell(cell:HouseCell, indexPath:NSIndexPath) {
        cell.houseImageView = UIImageView(image: UIImage(named: "house.jpg"))
    }
    
    func setLocationForHouse(cell:HouseCell, indexPath:NSIndexPath) {
        let houseLocation = houseLocations[indexPath.row] as CLLocation
        cell.houseLocation = houseLocation
    }
    
    /*
     * This function is called when the tableView is pulled down
     * and refreshes the view
     */
    func refresh(sender: AnyObject) {
        houseTableView?.reloadData()
        refreshControl.endRefreshing()
    }
    
    /**
     * gets all houses within a certain radius and displays them to the list
     */
    private func displayLocalHouses() {
        let pinDb = PinDatabase()
        pinDb.fetchPins(manager.location, radiusInMeters: 100000000) { (results) in
            if let finds = results {
                for r in finds {
                    let adr = r.objectForKey("address") as! String
                    let nickname = r.objectForKey("nickname") as! String
                    let loc = r.objectForKey("location") as! CLLocation
                    self.houseLocations.append(loc)
                    self.addressList.append(adr)
                    self.nickNameList.append(nickname)
                }
            }
        }
    }
    
    
}