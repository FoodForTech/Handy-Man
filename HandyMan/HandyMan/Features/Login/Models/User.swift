//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

class User {
    
    let id: Int
    let firstName: String
    let lastName: String
    let emailAddress: String
    let phoneNumber: String
    let userType: UserType
    let assignToUserId: Int
    let assignToFirstName:String
    let assignToLastName: String
    
     var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    init(id: Int = 0, type: Int = 1, firstName: String = "", lastName: String = "", emailAddress: String = "", phoneNumber: String = "", assignToFirstName: String = "", assignToLastName: String = "") {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.assignToUserId = -1 // TODO add to init signaature
        self.assignToFirstName = firstName
        self.assignToLastName = lastName
        
        if type == 1 {
            userType = .Issuer
        } else {
            userType = .Fixer
        }
    }
    
    func isEmpty() -> Bool {
        let noName = lastName.isEmpty || firstName.isEmpty
        let noEmail = emailAddress.isEmpty
        let idIsZero = id == 0
        
        return noName || noEmail || idIsZero
    }
    
}

enum UserType : Int {
    
    case Issuer
    case Fixer
    
}
