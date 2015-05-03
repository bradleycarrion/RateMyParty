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
    
    let userDatabase = UserDatabase.sharedInstance
    
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
        var email = usernameInput?.text
        var password1 = passwordInput?.text
        var password2 = repeatPasswordInput?.text
        var month = graduationMonth?.text.toInt()
        var year = graduationYear?.text.toInt()
        /*
        userDatabase.createNewUser(email!, password: password1!, graduationMonth: Int64(month!), graduationYear: Int64(year!)) {
            dispatch_async(dispatch_get_main_queue()) {self.userDatabase.getAll(){
                println("\n \nNew Scores")
                for x in self.userDatabase.users {
                    println("Email: \(x.email) Pwd: \(x.password)")
                }
                }}
        }*/
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}