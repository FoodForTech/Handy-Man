//
//  HandyManRestClient.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class HandyManRestClient {
    let baseURL: String
    
    // Singleton
    static let sharedInstance: HandyManRestClient = HandyManRestClient()
    private init() {
        baseURL = "https://api.500px.com/"
    }
    
    func getForService(service: ServiceRequest, parameters: [String: String], success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject)->Void) -> Void {
        
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(.GET, url, parameters: parameters)
            .responseJSON {
                (response) -> Void in
                switch response.result {
                case .Success:
                    success(response)
                case .Failure:
                    failure(response.result.error!)
                }
        }
    }
}
