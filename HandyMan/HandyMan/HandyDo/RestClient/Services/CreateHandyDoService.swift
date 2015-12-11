//
//  CreateHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class CreateHandyDoService: AuthenticatedService {
    
    var handyDo: HandyDo
    
    override init() {
        self.handyDo = HandyDo()
    }
    
    func createHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        self.handyDo = handyDo
        
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
        return "v1/handyDo/\(self.handyDo.id)"
    }
}
