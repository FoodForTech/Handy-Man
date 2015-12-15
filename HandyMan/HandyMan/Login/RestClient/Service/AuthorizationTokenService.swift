//
//  AuthorizationTokenService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class AuthorizationTokenService: AuthenticatedService {

   /**
    *  POST Method to Authorize a User via username and password
    */
    func authorizeUser(emailAddress: String, password: String, success:(User) -> Void, failure:(NSError) -> Void) -> Void {
        let credentialsDict: Dictionary<String, AnyObject> = ["emailAddress": emailAddress,
                                                              "password": password]
        HandyManRestClient.sharedInstance.postForService(self, postObjectDictionary: credentialsDict,
            success: { (response) -> Void in
                success(self.mapResponseToUser(response!))
            }, failure: { (errors) -> Void in
                failure((errors as? NSError)!)
            })
    }
    
    
    // MARK: Service Request
    
    override func serviceEndpoint() -> String {
        return "/v1/auth/token"
    }
    
    // MARK: Helper Methods
    
    func mapResponseToUser(response: Response<AnyObject, NSError>) -> User {
        let json = (JSON(data: response.data!)).array!
        
        return User(id: json[0]["id"].intValue,
                    type: json[0]["type"].intValue,
                    firstName: json[0]["first_name"].stringValue,
                    lastName: json[0]["last_name"].stringValue,
                    emailAddress: json[0]["email_address"].stringValue,
                    phoneNumber: json[0]["phone_number"].stringValue)
    }
    
}
