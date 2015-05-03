//
//  UserItem.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/3/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit

class UserItem: NSObject {
    var emailAddress: String
    var password: String
    var graduationMonth: Int64
    var graduationYear: Int64
    
    init(email: String, password: String, gradMonth: Int64, gradYear: Int64) {
        self.emailAddress = email
        self.password = password
        self.graduationMonth = gradMonth
        self.graduationYear = gradYear
        super.init()
    }
    
}
