//
//  AuthorizationTokenService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

final class AuthorizationTokenService {
    
    /**
     *  POST Method to Authorize a User
     */
    func authorizeUser(_ userCredentials: UserCredentials, success: @escaping (User) -> Void?, failure: @escaping (NSError) -> Void) -> Void {
        
        let credentialsDict: Dictionary<String, AnyObject> = ["emailAddress": userCredentials.emailAddress as AnyObject, "password": userCredentials.password as AnyObject]
        
        HMRestClient.postForService(self, postObjectDictionary: credentialsDict,
                                    success: {
                                        response in
                                        
                                        do {
                                            success(try self.mapResponseToUser(response))
                                        } catch {
                                            failure(NSError(domain: "domain", code: 400, userInfo: nil))
                                        }
        }, failure: {
            errors in
            
            failure((errors as? NSError)!)
        })
    }
    
    // MARK: - Request Mapping
    
    fileprivate func mapResponseToUser(_ response: DataResponse<Any>) throws -> User {
        if let data = response.data {
            return try User(json: JSON(data: data))
        }
        return User()
    }
    
}

// MARK: HMAuthenticatedService

extension AuthorizationTokenService : HMAuthenticatedService {
    
    func serviceEndpoint() -> String {
        return "/v1/auth/token"
    }
    
}
