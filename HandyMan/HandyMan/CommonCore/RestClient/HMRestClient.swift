//
//  HMRestClient.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import Alamofire

class HMRestClient {
    
    static let baseURL: String = "http://localhost:3000"
    
    // MARK: - GET Methods
    
    class func getForService(service: HMServiceRequest, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void ) -> Void {
        getForService(service, parameters: nil, success: success, failure: failure)
    }
    
    class func getForService(service: HMServiceRequest, parameters: [String: String]?, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) -> Void {
        
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
    
    class func postForService(service: HMServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success:(Response<AnyObject, NSError>) -> Void, failure:(AnyObject) -> Void) {
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
    
    class func deleteForService(service: HMServiceRequest, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) -> Void {
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(.DELETE, url).responseJSON { response -> Void in
            switch response.result {
            case .Success:
                success(response)
            case .Failure:
                failure(response.result.error!)
            }
        }
        
    }
    
    // MARK: - PUT Methods
    
    class func putForService(service: HMServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success:(Response<AnyObject, NSError>?) -> Void, failure:(AnyObject) -> Void) {
        
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
