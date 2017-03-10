//
//  UpdateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

final class UpdateHandyDoService: HMAuthenticatedService {
    
    func updateHandyDo(_ handyDo: HandyDo, success: @escaping (Bool) -> Void, failure: @escaping (NSError?) -> Void) {
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
    
    func mapHandyDoToDictionary(_ handyDo:HandyDo) -> Dictionary<String, AnyObject> {
        return ["id": handyDo.id as AnyObject,
                "title": handyDo.title as AnyObject,
                "description": handyDo.todo as AnyObject,
                "status": handyDo.status as AnyObject]
    }
}
