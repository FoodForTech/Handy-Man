//
//  AuthenticatedService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class AuthenticatedService: ServiceRequest {

    // MARK: ServiceRequest Protocol
    
    func serviceEndpoint() -> String {
        fatalError("Please override serviceEndpoint()")
    }
    
}
