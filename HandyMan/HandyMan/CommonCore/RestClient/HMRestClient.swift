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
                response in
                
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
            response in
            
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
        Alamofire.request(.DELETE, url).responseJSON {
            response in
            
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
            response in
            
            switch response.result {
            case .Success:
                success(response)
            case .Failure:
                failure(response.result.error!)
            }
        }
    }
}

//extension Alamofire.Request {
//    public func responseCollection<T: Decodable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
//        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
//            
//            guard error == nil else { return .Failure(error!) }
//            
//            let result = Alamofire
//                .Request
//                .JSONResponseSerializer(options: .AllowFragments)
//                .serializeResponse(request, response, data, error)
//            
//            switch result {
//            case .Success(let value):
//                do {
//                    return .Success(try [T].decode(value))
//                } catch {
//                    return .Failure(Error.errorWithCode(.JSONSerializationFailed,
//                        failureReason: "JSON parsing error, JSON: \(value)"))
//                }
//            case .Failure(let error): return.Failure(error)
//            }
//        }
//        
//        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
//    }
//}
