//
//  SignUpViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var freshmanImageView:UIImageView?
    @IBOutlet var usernameInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var repeatPasswordInput:UITextField?
    @IBOutlet var graduationMonth:UITextField?
    @IBOutlet var graduationYear:UITextField?
    @IBOutlet var signupButton:UIButton?
    @IBOutlet var cancelButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameInput?.placeholder = "new username"
        passwordInput?.placeholder = "new password"
        repeatPasswordInput?.placeholder = "repeat password"
        graduationMonth?.placeholder = "month"
        graduationYear?.placeholder = "year"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButtonPressed(sender:UIButton) {
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}