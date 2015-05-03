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
    var pbDataBase: CKDatabase?
    
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
    
    
    /*
    func checkIfUserExists(name: String, password: String) -> bool {
        
    }
    */
    
    /*
    func createNewUser(email: String, password: String, graduationMonth: Int64, graduationYear: Int64, closure: () -> ()) {
        let newUser = CKRecord(recordType: "User")
        newUser.setObject(email, forKey: "Email")
        newUser.setObject(password, forKey: "Password")
        newUser.setObject(graduationYear, forKey: "GradYear")
        newUser.setObject(graduationMonth, forKey: "GradMonth")
        pbDataBase?.saveRecord(newUser, completionHandler: { (newUser, error) in
            if let err = error {
                println("Error")
            }
            else {
                closure()
            }
        })
    }*/
    
    func getAll(closure: () -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Users", predicate: predicate)
        pbDataBase?.performQuery(query, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue()) { println("Load names fail")}
            }
            else {
                self.users.removeAll(keepCapacity: false)
                for result in results {
                    let email   : String = result.objectForKey("Email") as! String
                    let password  : String    = result.objectForKey("Password")   as! String
                    let newUser = UserItem(email: email, password: password)
                    self.users.append(newUser)
                }
                closure()
            }
        })
    }
    
    
}