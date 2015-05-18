//
//  ReviewDatabase.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/16/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import CloudKit

class ReviewDatabase: NSObject {
    
    override init() {}
    
    func pushReview(message: String, address:String, date: NSDate, closure: () -> ()) {
        let record = CKRecord(recordType: "Review")
        record.setObject(message, forKey: "message")
        record.setObject(address, forKey: "address")
        record.setObject(date, forKey: "date")
        
        TopCloud.pushToCloud(record, closure: closure)
    }
    
    func getHouseReviews(address:String, closure: ([AnyObject]?) -> ()) {
        let predicate = NSPredicate(format: "address = %@", address)
        let query = CKQuery(recordType: "Review", predicate: predicate)
        TopCloud.getQueryResults(query, closure: closure)
    }
}
