//
//  LoginBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginBusinessService: HMBusinessService {

    weak var uiDelegate: HMBusinessServiceUIDelegate?
    let authorizationTokenService: AuthorizationTokenService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        authorizationTokenService = AuthorizationTokenService()
    }
    
    func authorizeUser(userCredentials: UserCredentials, completionHandler:(user: User) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.authorizationTokenService.authorizeUser(userCredentials,
            success: { user in
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
                HMUserManager.sharedInstance.replaceEmptyUser(user)
                completionHandler(user: user)
            }, failure: { errors in
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
                self.handleErrors(errors)
            })
    }
    
    private func handleErrors(errors: NSError?) {
        if let errs = errors {
            print(errs)
        }
    }
 
}
