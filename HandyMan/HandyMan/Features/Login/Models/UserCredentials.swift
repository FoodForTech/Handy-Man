//
//  UserCredentials.swift
//  HandyMan
//
//  Created by Don Johnson on 4/15/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

struct UserCredentials {
    
    let firstName: String
    let lastName: String
    let emailAddress: String
    let password: String
    
    init(firstName: String = "", lastName: String = "", emailAddress: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.password = password
    }
    
    func isValid() -> Bool {
        return !emailAddress.isEmpty && !password.isEmpty
    }

}
