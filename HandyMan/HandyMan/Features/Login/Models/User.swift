//
//  User.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import Freddy

struct User {
    
    let id: Int
    let type: UserType
    let firstName: String
    let lastName: String
    let emailAddress: String
    let phoneNumber: String
    let assignToUserId: Int
    let assignToFirstName:String
    let assignToLastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(id: Int, type: UserType,
         firstName: String, lastName: String, emailAddress: String, phoneNumber: String,
         assignToUserId: Int, assignToFirstName: String, assignToLastName: String) {
        self.id = id
        self.type = type
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.assignToUserId = assignToUserId
        self.assignToFirstName = assignToFirstName
        self.assignToLastName = assignToLastName
    }
    
    // TODO: this is for a fix which I will resolve later; want to get this thing building and running in simulator
    init() {
        self.id = 0
        self.type = .issuer
        self.firstName = ""
        self.lastName = ""
        self.emailAddress = ""
        self.phoneNumber = ""
        self.assignToUserId = 0
        self.assignToFirstName = ""
        self.assignToLastName = ""
    }
    
    func isEmpty() -> Bool {
        let isMissingName = lastName.isEmpty || firstName.isEmpty
        let isMissingEmail = emailAddress.isEmpty
        let IsIdZero = id == 0
        
        return isMissingName || isMissingEmail || IsIdZero
    }
    
}

enum UserType: Int, JSONDecodable {
    
    case issuer = 1
    case fixer
    
}

extension User: JSONDecodable {
    
    init(json: JSON) throws {
        self.id = try json.getInt(at: "id")
        self.firstName = try json.getString(at: "firstName")
        self.lastName = try json.getString(at: "lastName")
        self.emailAddress = try json.getString(at: "emailAddress")
        self.phoneNumber = try json.getString(at: "phoneNumber")
        self.type = try json.decode(at: "type")
        self.assignToUserId = 2
        self.assignToFirstName = "Assign First"
        self.assignToLastName = "Assign last"
    }
    
}
