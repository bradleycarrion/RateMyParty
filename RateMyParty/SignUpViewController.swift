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
    @IBOutlet var emailAddressInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var repeatPasswordInput:UITextField?
    @IBOutlet var graduationMonth:UITextField?
    @IBOutlet var graduationYear:UITextField?
    @IBOutlet var signupButton:UIButton?
    @IBOutlet var cancelButton:UIButton?
    @IBOutlet var errorLabel: UILabel?
    
    let userDatabase = UserDatabase.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput?.secureTextEntry = true
        repeatPasswordInput?.secureTextEntry = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButtonPressed(sender:UIButton) {
        var email = emailAddressInput?.text
        var password1 = passwordInput?.text
        var password2 = repeatPasswordInput?.text
        var month = graduationMonth?.text.toInt()
        var year = graduationYear?.text.toInt()
        
        //if (email?.rangeOfString(".edu"))
        
        userDatabase.createNewUser(email!, password: password1!, graduationMonth: month!, graduationYear:year!) {}
    }
        
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}