//
//  UserCredentials.swift
//  HandyMan
//
//  Created by Don Johnson on 4/15/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

struct UserCredentials {
    
    let emailAddress: String
    let password: String
    
    func isValid() -> Bool {
        return !emailAddress.isEmpty && !password.isEmpty
    }

}
