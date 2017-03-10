//
//  HMRestClient.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import Alamofire

final class HMRestClient {
    
    static let baseURL: String = "http://localhost:3000"
    
    // MARK: - GET Methods
    
    class func getForService(_ service: HMServiceRequest,
                             success: @escaping (DataResponse<Any>?) -> Void,
                             failure: @escaping (AnyObject) -> Void ) -> Void {
        getForService(service, parameters: nil, success: success, failure: failure)
    }
    
    class func getForService(_ service: HMServiceRequest, parameters: [String: String]?,
                             success: @escaping (DataResponse<Any>?) -> Void,
                             failure: @escaping (AnyObject) -> Void) -> Void {
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON {
                (response: DataResponse<Any>) in
                
                switch response.result {
                case .success:
                    success(response)
                case .failure:
                    failure(response.result.error! as AnyObject)
                }
        }
    }
    
    // MARK: - POST Methods
    
    class func postForService(_ service: HMServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success: @escaping (DataResponse<Any>) -> Void, failure: @escaping (Any) -> Void) {
        
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(url, method: .post, parameters: postObjectDictionary).responseJSON {
            (response: DataResponse<Any>) in
            
            switch response.result {
            case .success:
                success(response)
            case .failure:
                failure(response.result.error! as AnyObject)
            }
        }
        
    }
    
    // MARK: - DELETE Methods
    
    class func deleteForService(_ service: HMServiceRequest, success: @escaping (DataResponse<Any>?) -> Void, failure:@escaping (AnyObject) -> Void) -> Void {
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(url, method: .delete).responseJSON {
            response in
            
            switch response.result {
            case .success:
                success(response)
            case .failure:
                failure(response.result.error! as AnyObject)
            }
        }
        
    }
    
    // MARK: - PUT Methods
    
    class func putForService(_ service: HMServiceRequest, postObjectDictionary: Dictionary<String, AnyObject>, success: @escaping (DataResponse<Any>?) -> Void, failure: @escaping (AnyObject) -> Void) {
        let url = baseURL + service.serviceEndpoint()
        Alamofire.request(url, method: .put).responseJSON {
            response in
            
            switch response.result {
            case .success:
                success(response)
            case .failure:
                failure(response.result.error! as AnyObject)
            }
        }
    }
}

enum HMServiceResult<Value, Error> {
    
    case success(Value)
    case failure(Error)
    
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
