//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

enum UserType: Int {
    case Issuer
    case Fixer
}

class User {

    // Singleton
    static let sharedInstance: User = User()
    private init(){}
    
    var id = "2"
    var firstName = "John"
    var lastName = "Doe"
    var occupation = "Software Engineer"
    var userType: UserType = .Fixer
    
    func fullNameFormatted() -> String {
        return firstName + " " + lastName
    }
    
}
