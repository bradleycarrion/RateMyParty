//
//  HouseTableViewController.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/10/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit

class HouseTableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    @IBOutlet var tableView: UITableView?
    var pins:[HouseItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init the table
        tableView!.delegate = self
        tableView!.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        //unwrap pins as houses
        if let houses = pins {
            //set cell attributes
            var pin = houses[indexPath.row]
            cell.textLabel?.text = pin.nickname
            cell.detailTextLabel?.text = pin.address
        }
        //return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if pins is not nil unwrap it as houses
        if let houses = pins {          
            return houses.count
        }
        //else return 0
        return 0
    }
    
    @IBAction func mapPressed() {
        //pop view controller and return to map
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
