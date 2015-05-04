//
//  CloudStorage.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import CloudKit

class UserDatabase: NSObject {
    let container = CKContainer.defaultContainer()
    let pbDataBase:CKDatabase
    var users = [UserItem]()
    
    override init() {
        pbDataBase = container.publicCloudDatabase
    }
    
    class var sharedInstance: UserDatabase {
        struct Static {
            static var instance: UserDatabase?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = UserDatabase()
        }
        return Static.instance!
    }
    
    func validateUserExists(email: String, password: String, closure: (success: Bool) -> ()) {
        let emailAddress  = NSPredicate(format: "email = %@", email)
        let passwordString  = NSPredicate(format: "password = %@", password)
        
        var predicate = NSCompoundPredicate.andPredicateWithSubpredicates([emailAddress, passwordString])
        
        let query = CKQuery(recordType: "User", predicate: emailAddress)
        pbDataBase.performQuery(query, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
            if (error != nil) {
                println("Error")
                dispatch_async(dispatch_get_main_queue()){ closure(success: false)}
                
            }
            else {
                let emailStr = results[0].objectForKey("email") as! String
                let passwordStr = results[0].objectForKey("password") as! String
                println("Email \(emailStr)  Password \(passwordStr)")
                println("EXISTS")
                closure(success: true)
            }
        })
    }
    
    
    func createNewUser(email: String, password: String, graduationMonth: Int, graduationYear: Int, closure: () -> ()) {
        let newUser = CKRecord(recordType: "User")
        newUser.setObject(email, forKey: "email")
        newUser.setObject(password, forKey: "password")
        newUser.setObject(graduationMonth, forKey: "gradMonth")
        newUser.setObject(graduationYear, forKey: "gradYear")


        pbDataBase.saveRecord(newUser, completionHandler: { (newUser, error) in
            if error != nil {
                println("Error")
            }
            else {
                closure()
            }
        })
    }
    
    
    
    
}