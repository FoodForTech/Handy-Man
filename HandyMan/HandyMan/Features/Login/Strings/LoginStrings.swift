//
//  LoginStrings.swift
//  HandyMan
//
//  Created by Don Johnson on 3/9/17.
//  Copyright © 2017 Don Johnson. All rights reserved.
//

enum LoginStrings: String {
    
    case LoginErrorTitle = "Missing Required Info"
    case LoginErrorMessage = "Both the email and password are required to access your accounts."
    case AuthErrorTitle = "Authentication Failed"
    case AuthErrorMessage = "Your credentials cannot be authenticated.  Please try again."
    case AuthErrorOkButtonTitle = "OK"
    
}

extension LoginStrings {
    
    var localized: String {
        return self.rawValue
    }
    
}
