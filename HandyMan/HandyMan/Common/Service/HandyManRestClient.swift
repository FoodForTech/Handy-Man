//
//  HandyManRestClient.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit
import Alamofire

class HandyManRestClient {
    let baseURL: String
    
    var serviceLink: String
    
    init() {
        baseURL = "https://www.google.com/"
        serviceLink = ""
    }
    
    func get(success:(AnyObject)->Void, failure:(AnyObject)->Void) -> Void {
        Alamofire.request(.GET, baseURL + self.serviceLink).responseJSON { (response) -> Void in
            switch response.result {
            case .Success:
                success(response.response!)
            case .Failure:
                failure(response.result.error!)
            }
        }
    }
}
