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
    var assignToUserId: Int
    var assignToFirstName:String
    var assignToLastName: String
    
    init(id: Int, type: Int, firstName: String, lastName: String, emailAddress: String, phoneNumber: String, assignToFirstName: String, assignToLastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.assignToUserId = -1 // TODO add to init signaature
        self.assignToFirstName = firstName
        self.assignToLastName = lastName
        
        self.assignToUserId = -1
        
        if type == 1 {
            userType = .Issuer
        } else {
            userType = .Fixer
        }
    }
    
    convenience init() {
        self.init(id: 0, type: 1, firstName: "", lastName: "", emailAddress: "", phoneNumber: "", assignToFirstName: "", assignToLastName: "")
    }
        
    func fullNameFormatted() -> String {
        return firstName + " " + lastName
    }
    
}