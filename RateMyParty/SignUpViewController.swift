//
//  SignUpViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var freshmanImageView:UIImageView?
    @IBOutlet var emailAddressInput:UITextField?
    @IBOutlet var passwordInput:UITextField?
    @IBOutlet var repeatPasswordInput:UITextField?
    @IBOutlet var graduationMonth:UITextField?
    @IBOutlet var graduationYear:UITextField?
    @IBOutlet var signupButton:UIButton?
    @IBOutlet var cancelButton:UIButton?
    @IBOutlet var errorLabel: UILabel?
    
    private let userDatabase = UserDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressInput?.returnKeyType = UIReturnKeyType.Next
        passwordInput?.secureTextEntry = true
        passwordInput?.returnKeyType = UIReturnKeyType.Next
        repeatPasswordInput?.secureTextEntry = true
        repeatPasswordInput?.returnKeyType = UIReturnKeyType.Done
        graduationMonth?.returnKeyType = UIReturnKeyType.Next
        graduationYear?.returnKeyType = UIReturnKeyType.Next
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //check length of password greater than 6
    @IBAction func signupButtonPressed(sender:UIButton) {
        var errorPopUp = UIAlertController()
        errorPopUp.title = "Sign Up Error"
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: {(alert) in
            errorPopUp.dismissViewControllerAnimated(true, completion: nil)
        })
        errorPopUp.addAction(action)
        var validCredentials:Bool = true
        var errorString:String?
        
        let email = emailAddressInput?.text
        let password1 = passwordInput?.text
        let password2 = repeatPasswordInput?.text
        let month = graduationMonth?.text.toInt()
        let year = graduationYear?.text.toInt()
        let objCEmail = email! as NSString
        
       
        //check to see if all fields are filled
        if (email! == "" || password1! == "" || password2! == "" || graduationMonth?.text == "" || graduationYear?.text == "" ) {
            errorString = "All fields must be completed"
            validCredentials = false
        }
        //check for matching passwords
        else if (password1 != password2) {
            errorString = "Passwords do not match"
            validCredentials = false
        }
        //check for valid email
        else if (!objCEmail.containsString("@")) {
            println("Not valid email")
            errorString = "Need valid email adress"
            validCredentials = false
        }
        //check for valid edu email
        else if (!email!.hasSuffix(".edu")) {
            println("not valid edu")
            errorString = "Need .edu address"
            validCredentials = false
        }
        
        //if everything looks good, check database for email
        if (validCredentials) {
            //checks to see if the email adress is not already in the system
            userDatabase.checkExistingEmail(email!, closure: {(success) in
                if (!success) {
                    //if so, create account
                    self.userDatabase.createNewUser(email!, password: password1!, graduationMonth: month!, graduationYear:year!) {/*some closure*/}
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    //set error message
                    errorPopUp.message = "This email adress is already associated with a user. Please try a different another."
                    self.presentViewController(errorPopUp, animated: true, completion: nil)
                }
            })
        }
        else {
            errorPopUp.message = errorString!
            self.presentViewController(errorPopUp, animated: true, completion: nil)

        }
        
    }
    
    /**
        fix to jump from text box to text box
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //handles the keyboards
        return textField.resignFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}