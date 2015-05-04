//
//  AddHouseViewController.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit

class AddHouseViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var adressIn:   UITextField?
    @IBOutlet var nickNameIn: UITextField?
    @IBOutlet var addButton:  UIButton?
    var delegate:     AddHouseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    

    @IBAction func addPressed(button: UIButton) {
        delegate?.addPin(adressIn!.text, nickName: nickNameIn!.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
