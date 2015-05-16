//
//  MainHouseListView.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/13/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit

class MainHouseListView: ViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var houseTableView: UITableView?
    
    // creates a white background to better see the time and power
    let timePowerBar = UIView()
    
    var addressArray = [String]()
    
    override func viewDidLoad() {
        
        houseTableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        timePowerBar.frame = CGRectMake(0, 0, self.view.frame.width, 20)
        timePowerBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(timePowerBar)
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        super.viewDidLoad()
        houseTableView?.delegate = self
        houseTableView?.dataSource = self
        /*
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell:UITableViewCell = houseTableView?.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.addressArray[indexPath.row]
        return cell
        /*
        let cellIdentifier = "cell"
        
        var cell : UITableViewCell = houseTableView!.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        cell.textLabel?.text = self.addressArray[indexPath.row]
        var image : UIImage = UIImage(named: "freshman")!
        println("The loaded image: \(image)")
        cell.imageView!.image = image
        
        return cell
*/
    }
    
    func refresh() {
        houseTableView?.reloadData()
    }
    
    func addHouseToView(name: String) {
        addressArray.append(name)
        houseTableView!.reloadData()
    }
}