//
//  CommonBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import Foundation

protocol CommonBusinessServiceUIDelegate {
    func willCallBlockingBusinessService(businessService: CommonBusinessService)
    func didCompleteBlockingBusinessService(businessService: CommonBusinessService)
    func didFailWithBusinessService(businessService: CommonBusinessService)
}

class CommonBusinessService: NSObject {

}