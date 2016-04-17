//
//  HMBusinessServiceUIDelegate.swift
//  HandyMan
//
//  Created by Don Johnson on 4/5/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

protocol HMBusinessServiceUIDelegate : class {

    func willCallBlockingBusinessService(businessService: HMBusinessService)
    func didCompleteBlockingBusinessService(businessService: HMBusinessService)

}
