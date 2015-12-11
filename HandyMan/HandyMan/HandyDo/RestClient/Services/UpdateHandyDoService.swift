//
//  UpdateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class UpdateHandyDoService: AuthenticatedService {

    // Mock Service to update a HandyDo
    
    func updateHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        let parameters = ["consumer_key":"5jvwMuSo2ofiAUCx0wNar7OvDlE8m22tpdGJXcYx"]
        HandyManRestClient.sharedInstance.getForService(self, parameters: parameters,
            success: { (response) -> Void in
                success(true)
            },
            failure: {(errors) -> Void in
                failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceRequest Protocol
    
    override func serviceEndpoint() -> String {
        return "v1/"
    }
}
