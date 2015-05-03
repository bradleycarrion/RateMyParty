//
//  CloudStorage.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/2/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import CloudKit

class LoginBatabase: NSObject {
    let container = CKContainer.defaultContainer()
    var pbDataBase: CKDatabase?
    
    override init() {
        pbDataBase = container.publicCloudDatabase
    }
    
    class var sharedInstance: LoginBatabase {
        struct Static {
            static var instance: LoginBatabase?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = LoginBatabase()
        }
        return Static.instance!
    }
    
    
    
    func checkIfUserExists(name: String, password: String) -> bool {
        return true
    }
    
    
    
    func createNewUser(name: String, password: String, graduationMonth: Int, graduationYear: Int) {
        let newUser = CKRecord(recordType: "User")
        
        
    }
    
    
    
    
}