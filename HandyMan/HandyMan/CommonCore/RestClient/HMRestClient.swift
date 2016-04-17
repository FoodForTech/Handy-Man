//
//  HandyManRestClient.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import Alamofire

class HMRestClient {
    let baseURL: String
    
    // Singleton
    static let sharedInstance: HandyManRestClient = HMRestClient()
    private init() {
        baseURL = "http://50.165.48.172:3000";
    }
    
    // MARK: - GET Methods
    
    func getForService(service: ServiceRequest, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void ) -> Void {
        getForService(service, parameters: nil, success: success, failure: failure)
    }
    
    func getForService(service: ServiceRequest, parameters: [String: String]?, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) -> Void {
        
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
    
    // MARK: - POST Methods
    
    func postForService(service: ServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) {
        
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(.POST, url, parameters: postObjectDictionary, encoding: .JSON).responseJSON {
            (response) -> Void in
            switch response.result {
            case .Success:
                success(response)
            case .Failure:
                failure(response.result.error!)
            }
        }
        
    }
    
    // MARK: - DELETE Methods
    
    func deleteForService(service: ServiceRequest, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) -> Void {
        
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(.DELETE, url).responseJSON { (response) -> Void in
            switch response.result {
            case .Success:
                success(response)
            case .Failure:
                failure(response.result.error!)
            }
        }
        
    }
    
    // MARK: - PUT Methods
    
    func putForService(service: ServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) {
        
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(.PUT, url, parameters: postObjectDictionary, encoding: .JSON).responseJSON {
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
