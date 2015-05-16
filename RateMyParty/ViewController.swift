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
    let userDatabase = UserDatabase()
    
    @IBOutlet var backgroundImageView:UIImageView?
    @IBOutlet var emailAddressInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var signupButton:UIButton?
    @IBOutlet var spin: UIActivityIndicatorView?
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput?.secureTextEntry = true
        passwordInput?.delegate = self
        passwordInput?.returnKeyType = UIReturnKeyType.Done
        emailAddressInput?.delegate = self
        emailAddressInput?.returnKeyType = UIReturnKeyType.Next
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
        ONE CHANGE TO MAKE: change param to an enum value so it can account for lack of network
      */
    @IBAction func loginButtonPressed(sender: UIButton) {
        if (emailAddressInput!.text == "" && passwordInput?.text == "") {
            return
        } else {
            
            spin?.startAnimating()
            userDatabase.validateUserExists(emailAddressInput!.text, password: passwordInput!.text, closure: {(success: Bool) -> () in
            
                if (success) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        self.spin?.stopAnimating()
                    }
                }
                else {
                   
                    let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: {(action) in
                        alert.dismissViewControllerAnimated(true, completion: nil)
                    })
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    self.spin?.stopAnimating()
                    
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
        if (textField == emailAddressInput!) {
            emailAddressInput?.resignFirstResponder()
            passwordInput?.becomeFirstResponder()
        }
        else if (textField == passwordInput) {
            passwordInput?.resignFirstResponder()
            loginButtonPressed(UIButton())
        }
        return true
    }
    


}

