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

    // Mock Service to Delete a handy do
    
    func deleteHandyDo(handyDo: HandyDo, success: NSURLResponse? -> Void, failure: NSError? -> Void) {
        
        Alamofire.request(.GET, "https://www.google.com/#q=Alamofire").responseJSON { (response) -> Void in
            switch response.result {
            case .Success:
                success(response.response)
            case .Failure:
                failure(response.result.error)
            }
        }
    }
}
