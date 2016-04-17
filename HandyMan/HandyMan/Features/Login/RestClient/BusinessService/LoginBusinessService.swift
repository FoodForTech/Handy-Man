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
    
    func authorizeUser(userCredentials: UserCredentials, completionHandler:(user: User) -> Void) {
        self.authorizationTokenService.authorizeUser(userCredentials,
            success: { user in
                HMUserManager.sharedInstance.setEmptyUser(user)
                completionHandler(user: user)
            }, failure: { errors in
                // TODO
            })
    }
 
}
