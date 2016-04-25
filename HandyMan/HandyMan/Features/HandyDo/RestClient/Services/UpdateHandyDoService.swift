//
//  UpdateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class UpdateHandyDoService: HMAuthenticatedService {
    
    func updateHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        let handyDoDict: [String: AnyObject] = self.mapHandyDoToDictionary(handyDo)
        HMRestClient.putForService(self, postObjectDictionary: handyDoDict,
            success: { (response) -> Void in
                success(true)
            },
            failure: {(errors) -> Void in
                failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceRequest Protocol
    
    func serviceEndpoint() -> String {
        return "/v1/handyDo"
    }
    
    // MARK: - Request Mapping
    
    func mapHandyDoToDictionary(handyDo:HandyDo) -> Dictionary<String, AnyObject> {
        return ["id": handyDo.id,
                "title": handyDo.title,
                "description": handyDo.todo,
                "status": handyDo.status]
    }
}
