//
//  DeleteHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

final class DeleteHandyDoService {

    var handyDo: HandyDo = HandyDo();
    
    func deleteHandyDo(_ handyDo: HandyDo, success: @escaping (Bool) -> Void, failure: @escaping (NSError?) -> Void) {
        self.handyDo = handyDo;
        HMRestClient.deleteForService(self,
            success: { response in
                success(true)
            },
            failure: { errors in
                failure(errors as? NSError)
        })
    }

}

// MARK: ServiceRequest Protocol
    
extension DeleteHandyDoService : HMAuthenticatedService {
    
    func serviceEndpoint() -> String {
        return "/v1/handyDo/\(self.handyDo.id)"
    }
    
}
