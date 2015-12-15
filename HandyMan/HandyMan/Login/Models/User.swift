//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

enum UserType: Int {
    case Issuer
    case Fixer
}

class User {
    
    var id: Int
    var firstName: String
    var lastName: String
    var emailAddress: String
    var phoneNumber: String
    var userType: UserType
    
    init(id: Int, type: Int, firstName: String, lastName: String, emailAddress: String, phoneNumber: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        
        if type == 1 {
            userType = .Issuer
        } else {
            userType = .Fixer
        }
    }
    
    convenience init() {
        self.init(id: 0, type: 1, firstName: "", lastName: "", emailAddress: "", phoneNumber: "")
    }
        
    func fullNameFormatted() -> String {
        return firstName + " " + lastName
    }
    
}