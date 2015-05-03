//
//  ViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var backgroundImageView:UIImageView?
    @IBOutlet var userNameInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var signupButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userNameInput?.placeholder = "username"
        passwordInput?.placeholder = "password"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
    }
    
    @IBAction func signUpBottonPressed(sender:UIButton) {
    }
    
    


}

