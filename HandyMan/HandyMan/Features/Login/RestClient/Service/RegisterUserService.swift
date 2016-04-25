//
//  RegisterUserService.swift
//  HandyMan
//
//  Created by Don Johnson on 4/22/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

class RegisterUserService {

    func registerUser(user: User, password: String, completion: Bool -> Void) {
        
        let postObjectDict = ["firstName": user.firstName,
                              "lastName": user.lastName,
                              "emailAddress": user.emailAddress,
                              "password": password,
                              "phoneNumber": user.phoneNumber]
        
        HMRestClient.postForService(self, postObjectDictionary: postObjectDict, success: {
            response in
            
            switch response.result {
            case .Success:
                completion(true)
            case .Failure:
                completion(false)
            }
            
        }) {
            failure in
            
            print("everything will eventually be ok")
        }
        
    }

}

extension RegisterUserService : HMAuthenticatedService {
    
    func serviceEndpoint() -> String {
        return "/v1/registration"
    }
    
}
