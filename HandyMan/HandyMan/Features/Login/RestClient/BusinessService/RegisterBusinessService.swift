//
//  RegisterBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 4/22/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

final class RegisterBusinessService: HMBusinessService {
    
    weak var uiDelegate: HMBusinessServiceUIDelegate?
    let registerUserService: RegisterUserService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        self.registerUserService = RegisterUserService()
    }
    
    func registerUser(_ user: User, password: String, completion: @escaping (Bool) -> Void) {
        
        self.registerUserService.registerUser(user, password: password) {
            isSuccessful in
            
            if isSuccessful {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
