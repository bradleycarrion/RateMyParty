//
//  AddHouseViewController.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/3/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit

class AddHouseViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var adressIn:   UITextField?
    @IBOutlet var nickNameIn: UITextField?
    @IBOutlet var backButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
