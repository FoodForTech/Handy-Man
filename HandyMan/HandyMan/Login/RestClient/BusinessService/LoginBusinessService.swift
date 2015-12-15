//
//  LoginBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

protocol LoginBusinessServiceNavigationDelegate {
    func didLoginWithBusinessService(service: LoginBusinessService, user: User)
}

protocol LoginBusinessServiceUIDelegate: CommonBusinessServiceUIDelegate {}

class LoginBusinessService: CommonBusinessService {

    let authorizationTokenService: AuthorizationTokenService
    var navigationDelegate: LoginBusinessServiceNavigationDelegate
    var uiDelegate: LoginBusinessServiceUIDelegate
    
    init(navigationDelegate: LoginBusinessServiceNavigationDelegate, uiDelegate: LoginBusinessServiceUIDelegate) {
        self.navigationDelegate = navigationDelegate
        self.uiDelegate = uiDelegate
        authorizationTokenService = AuthorizationTokenService()
    }
    
    func authorizeUserWithEmailAddress(emailAddress: String, password: String) {
        self.authorizationTokenService.authorizeUser(emailAddress, password: password,
            success: {(user) -> Void in
                UserManager.sharedInstance.user(user)
                self.navigationDelegate.didLoginWithBusinessService(self, user: user)
            }, failure: {(errors) -> Void in
                //
            })
    }
 
}
