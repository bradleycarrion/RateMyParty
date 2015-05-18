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
    
    /**
      * checks to see if password/email combo is in the database
      */
    func validateUserExists(email: String, password: String, closure: (success: Bool) -> ()) {
        let emailAddress  = NSPredicate(format: "email = %@", email)
        let passwordString  = NSPredicate(format: "password = %@", password)
        var predicate = NSCompoundPredicate.andPredicateWithSubpredicates([emailAddress, passwordString])
        
        TopCloud.query(predicate, recordType: "User", closure: closure)
        
    }
    
    /**
      *  querys the database to check and see if the email is already in use
      *  returns success as parameter of a closure
      */
    func checkExistingEmail(email: String, closure: (success:Bool) -> ()) {
        let emailAddress  = NSPredicate(format: "email = %@", email)
        TopCloud.query(emailAddress, recordType: "User", closure: closure)
    }
    
    /**
      * adds new user to the data base
      */
    func createNewUser(email: String, password: String, graduationMonth: Int, graduationYear: Int, closure: () -> ()) {
        let newUser = CKRecord(recordType: "User")
        newUser.setObject(email, forKey: "email")
        newUser.setObject(password, forKey: "password")
        newUser.setObject(graduationMonth, forKey: "gradMonth")
        newUser.setObject(graduationYear, forKey: "gradYear")
        TopCloud.pushToCloud(newUser, closure: closure)

    }
    
        
    
    
}