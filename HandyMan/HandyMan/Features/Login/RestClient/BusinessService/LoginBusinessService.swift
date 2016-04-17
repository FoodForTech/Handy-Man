//
//  LoginBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

class LoginBusinessService: HMBusinessService {

    weak var uiDelegate: HMBusinessServiceUIDelegate?
    let authorizationTokenService: AuthorizationTokenService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        authorizationTokenService = AuthorizationTokenService()
    }
    
    func authorizeUserWithEmailAddress(emailAddress: String, password: String, completionHandler:(user: User) -> Void) {
        self.authorizationTokenService.authorizeUser(emailAddress, password: password,
            success: { user in
                HMUserManager.sharedInstance.user = user
                completionHandler(user: user)
            }, failure: { errors in
                // TODO
            })
    }
 
}
