//
//  TopCloud.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import CloudKit

class TopCloud: NSObject {
    
    //put instance methods in a struct so they can be accessed as static
    internal struct StaticMembers {
        static let container = CKContainer.defaultContainer()
        static let pbDataBase:CKDatabase =  container.publicCloudDatabase
    }
    
    override private init() {}
    
    /**
        Returns the singleton instance for the class
      */
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
    
    /**
      * Query database with predicate and recordtype
      * calls closure with True or false value based on success
      */
    class func query(predicate: NSPredicate, recordType:String, closure: (success:Bool) -> ()) {
        
        let query = CKQuery(recordType: recordType, predicate: predicate)
        StaticMembers.pbDataBase.performQuery(query, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
            if (error != nil) {
                println("Error")
                dispatch_async(dispatch_get_main_queue()){ closure(success: false)}
                
            }
            else {
                if (results.count > 0) {
                    dispatch_async(dispatch_get_main_queue()){ closure(success: true)}
                }
                else {
                    closure(success: false)
                }
            }
        })
    }
    
    /**
      * Class method to push data to Cloud
      * Takes a record and a closure
      */
    class func pushToCloud(record: CKRecord, closure: () -> ()) {
        StaticMembers.pbDataBase.saveRecord(record, completionHandler: { (record, error) in
            if error != nil {
                println("Error")
            }
            else {
                closure()
            }
        })
    }
    
    /**
      * gets all the results for a given query
      * returns the results as a parameter in a closure
      */
    class func getQueryResults(query: CKQuery, closure: (qResults: [AnyObject]?) -> ()) {
        StaticMembers.pbDataBase.performQuery(query, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
            if (error != nil) {
                println("Error")
                dispatch_async(dispatch_get_main_queue()){ closure(qResults: nil)}
                
            }
            else {
                if (results.count > 0) {
                    dispatch_async(dispatch_get_main_queue()){ closure(qResults: results)}
                }
            }
        })
    }

    
    
   
}
