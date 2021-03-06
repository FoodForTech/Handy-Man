//
//  UserCredentials.swift
//  HandyMan
//
//  Created by Don Johnson on 4/15/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import Freddy

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

extension UserCredentials: JSONEncodable {
    
    func toJSON() -> JSON {
        let parameters = ["firstName" : self.firstName.toJSON(),
                          "lastName" : self.lastName.toJSON(),
                          "emailAddress" : self.emailAddress.toJSON(),
                          "password" : self.password.toJSON()]
        return .dictionary(parameters)
    }
    
}
