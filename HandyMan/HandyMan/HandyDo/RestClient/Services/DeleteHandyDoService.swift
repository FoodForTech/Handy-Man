//
//  DeleteHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class DeleteHandyDoService: AuthenticatedService {

    var handyDo: HandyDo = HandyDo();
    
    func deleteHandyDo(handyDo: HandyDo, success: Bool -> Void, failure: NSError? -> Void) {
        self.handyDo = handyDo;
        HandyManRestClient.sharedInstance.deleteForService(self,
            success: { (response) -> Void in
                success(true)
            },
            failure: {(errors) -> Void in
                failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceRequest Protocol
    
    override func serviceEndpoint() -> String {
        return "/v1/handyDo/\(self.handyDo.id)"
    }
}
