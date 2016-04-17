//
//  AuthorizationTokenService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class AuthorizationTokenService: HMAuthenticatedService {
    
    /**
     *  POST Method to Authorize a User
     */
    func authorizeUser(userCredentials: UserCredentials, success:(User) -> Void, failure:(NSError) -> Void) -> Void {
        let credentialsDict: Dictionary<String, AnyObject> = ["emailAddress": userCredentials.emailAddress, "password": userCredentials.password]
        HMRestClient.sharedInstance.postForService(self, postObjectDictionary: credentialsDict,
            success: { response in
                success(self.mapResponseToUser(response))
            }, failure: { errors in
                failure((errors as? NSError)!)
        })
    }
    
    
    // MARK: - HMServiceRequest
    
    func serviceEndpoint() -> String {
        return "/v1/auth/token"
    }
    
    // MARK: - Request Mapping
    
    private func mapResponseToUser(response: Response<AnyObject, NSError>) -> User {
        if let data = response.data {
            if let json = JSON(data: data).array {
                return User(id: json[0]["id"].intValue,
                            type: json[0]["type"].intValue,
                            firstName: json[0]["first_name"].stringValue,
                            lastName: json[0]["last_name"].stringValue,
                            emailAddress: json[0]["email_address"].stringValue,
                            phoneNumber: json[0]["phone_number"].stringValue,
                            assignToFirstName: json[0]["assign_to_first_name"].stringValue,
                            assignToLastName: json[0]["assign_to_last_name"].stringValue)
            }
        }
        return User() // empty user
    }
    
}
