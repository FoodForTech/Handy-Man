//
//  CommonBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

protocol CommonBusinessServiceUIDelegate {
    func willCallBlockingBusinessService(businessService: CommonBusinessService)
    func didCompleteBlockingBusinessService(businessService: CommonBusinessService)
}

class CommonBusinessService: NSObject {

}