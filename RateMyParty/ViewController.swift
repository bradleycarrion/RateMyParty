//
//  ViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let userDatabase = UserDatabase.sharedInstance
    
    @IBOutlet var backgroundImageView:UIImageView?
    @IBOutlet var emailAddressInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var signupButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        if (emailAddressInput!.text == "" && passwordInput?.text == "") {
            return
        } else {
            userDatabase.validateUserExists(emailAddressInput!.text, password: passwordInput!.text, closure: {(success: Bool) -> () in
                if (success) {
                    println("It worked")
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    
                }
                else {
                    println("User not found")
                }
            })
            
            
        }
    }
    
    @IBAction func signUpBottonPressed(sender:UIButton) {
        
    }
    


}

