//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

enum UserType: Int {
    case User
    case HandyMan
}

class User {

    // Singleton
    static let sharedInstance: User = User()
    private init(){}
    
    var firstName = "Donald"
    var lastName = "Johnson"
    var occupation = "Software Engineer"
    var userType: UserType = .User
    
}
