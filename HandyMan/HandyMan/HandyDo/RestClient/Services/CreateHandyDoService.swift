//
//  CreateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class CreateHandyDoService: AuthenticatedService {
    
    func createHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        let handyDoDict = self.mapHandyDoToPostDictionary(handyDo)
        HandyManRestClient.sharedInstance.postForService(self, postObjectDictionary: handyDoDict,
            success: { (response) -> Void in
                success(true)
            },
            failure: {(errors) -> Void in
                failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceRequest Protocol
    
    override func serviceEndpoint() -> String {
        return "/v1/handyDo"
    }
    
    // MARK: - Request Mapping
    
    func mapHandyDoToPostDictionary(handyDo: HandyDo) -> Dictionary<String, AnyObject> {
        let dictionary: Dictionary<String, AnyObject> = ["title": handyDo.title,
                                                         "description":handyDo.todo,
                                                         "status": handyDo.status]
        return dictionary
    }
}
