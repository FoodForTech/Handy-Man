//
//  CreateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class CreateHandyDoService: HMAuthenticatedService {
    
    func createHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        let handyDoDict = self.mapHandyDoToPostDictionary(handyDo)
        HMRestClient.sharedInstance.postForService(self, postObjectDictionary: handyDoDict,
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
    
    private func mapHandyDoToPostDictionary(handyDo: HandyDo) -> Dictionary<String, AnyObject> {
        return ["id": handyDo.id,
                "title": handyDo.title,
                "description":handyDo.todo,
                "status": handyDo.status]
    }
    
}
