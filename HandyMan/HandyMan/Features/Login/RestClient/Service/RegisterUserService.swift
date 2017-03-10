//
//  RegisterUserService.swift
//  HandyMan
//
//  Created by Don Johnson on 4/22/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

final class RegisterUserService {

    func registerUser(_ user: User, password: String, completion: @escaping (Bool) -> Void) {
        
        let postObjectDict = ["firstName": user.firstName,
                              "lastName": user.lastName,
                              "emailAddress": user.emailAddress,
                              "password": password,
                              "phoneNumber": user.phoneNumber]
        
        HMRestClient.postForService(self, postObjectDictionary: postObjectDict as Dictionary<String, AnyObject>, success: {
            response in
            
            switch response.result {
            case .success:
                completion(true)
            case .failure:
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
