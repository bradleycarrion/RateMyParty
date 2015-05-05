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
    
    override init() {}
    
    func validateUserExists(email: String, password: String, closure: (success: Bool) -> ()) {
        let emailAddress  = NSPredicate(format: "email = %@", email)
        let passwordString  = NSPredicate(format: "password = %@", password)
        var predicate = NSCompoundPredicate.andPredicateWithSubpredicates([emailAddress, passwordString])
        
        TopCloud.query(predicate, recordType: "User", closure: closure)
        
    }
    
    
    func createNewUser(email: String, password: String, graduationMonth: Int, graduationYear: Int, closure: () -> ()) {
        let newUser = CKRecord(recordType: "User")
        newUser.setObject(email, forKey: "email")
        newUser.setObject(password, forKey: "password")
        newUser.setObject(graduationMonth, forKey: "gradMonth")
        newUser.setObject(graduationYear, forKey: "gradYear")
        TopCloud.pushToCloud(newUser, closure: closure)

    }
    
    
    
    
}