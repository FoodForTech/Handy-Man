//
//  CreateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class CreateHandyDoService: HMAuthenticatedService {
    
    func createHandyDo(_ handyDo: HandyDo, success: @escaping (Bool) -> Void, failure: @escaping (NSError?) -> Void) {
        let handyDoDict = self.mapHandyDoToPostDictionary(handyDo)
        HMRestClient.postForService(self, postObjectDictionary: handyDoDict,
            success: { response in
                success(true)
            },
            failure: { errors in
                failure(errors as? NSError)
        })
    }
    
    // MARK: - ServiceRequest Protocol
    
    func serviceEndpoint() -> String {
        return "/v1/handyDo"
    }
    
    // MARK: - Request Mapping
    
    fileprivate func mapHandyDoToPostDictionary(_ handyDo: HandyDo) -> Dictionary<String, AnyObject> {
        return ["id": handyDo.id as AnyObject,
                "title": handyDo.title as AnyObject,
                "description":handyDo.todo as AnyObject,
                "status": handyDo.status as AnyObject]
    }
    
}
