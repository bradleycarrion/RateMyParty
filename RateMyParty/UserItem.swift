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
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        super.init()
    }
    
}
