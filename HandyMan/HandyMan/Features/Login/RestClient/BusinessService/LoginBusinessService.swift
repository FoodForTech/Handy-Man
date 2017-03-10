//
//  LoginBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class LoginBusinessService: HMBusinessService {

    weak var uiDelegate: HMBusinessServiceUIDelegate?
    let authorizationTokenService: AuthorizationTokenService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        authorizationTokenService = AuthorizationTokenService()
    }
    
    func authorizeUser(_ userCredentials: UserCredentials, completionHandler: @escaping (_ user: User) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.authorizationTokenService.authorizeUser(userCredentials,
            success: {
                (user: User) in
                
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
                HMUserManager.sharedInstance.replaceEmptyUser(user)
                return completionHandler(user)
            }, failure: {
                (errors: NSError) in
                
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
                self.handleErrors(errors)
                return completionHandler(User())
            })
    }
    
    private func handleErrors(_ errors: NSError?) {
        if let errs = errors {
            print(errs)
        }
    }
 
}
