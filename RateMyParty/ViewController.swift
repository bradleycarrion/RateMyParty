//
//  ViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {
    let userDatabase = UserDatabase.sharedInstance
    
    @IBOutlet var backgroundImageView:UIImageView?
    @IBOutlet var emailAddressInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var signupButton:UIButton?
    @IBOutlet var spin: UIActivityIndicatorView?
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput!.secureTextEntry = true
        passwordInput?.delegate = self
        emailAddressInput?.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            
            manager.requestWhenInUseAuthorization()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        if (emailAddressInput!.text == "" && passwordInput?.text == "") {
            return
        } else {
            
            spin?.startAnimating()
            userDatabase.validateUserExists(emailAddressInput!.text, password: passwordInput!.text, closure: {(success: Bool) -> () in
            
                if (success) {
                    println("It worked")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        self.spin?.stopAnimating()
                    }
                    
                }
                else {
                    println("User not found")
                }
                
            })
            
            
        }
    }
    
    @IBAction func signUpBottonPressed(sender:UIButton) {
        
    }
    
    
    /**
      *  TextField Delegate functions
      */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    


}

