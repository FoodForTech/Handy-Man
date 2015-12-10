//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class User: NSObject {

    // Singleton
    static let sharedInstance: User = User()
    private override init(){}
    
    var firstName = "Donald"
    var lastName = "Johnson"
    var occupation = "Software Engineer"
    
}
