//
//  ReviewItem.swift
//  RateMyParty
//
//  Created by Bert Heinzelman on 5/16/15.
//  Copyright (c) 2015 BB. All rights reserved.
//


class ReviewItem: NSObject {
    let date:NSDate
    let address:String
    let message:String
    
    init(date:NSDate, address:String, message:String) {
        self.date = date
        self.address = address
        self.message = message
    }
}
