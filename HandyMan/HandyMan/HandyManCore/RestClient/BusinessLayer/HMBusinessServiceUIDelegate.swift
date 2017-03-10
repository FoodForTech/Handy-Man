//
//  HMBusinessServiceUIDelegate.swift
//  HandyMan
//
//  Created by Don Johnson on 4/5/16.
//  Copyright © 2016 Don Johnson. All rights reserved.
//

import UIKit

protocol HMBusinessServiceUIDelegate: class {

    func willCallBlockingBusinessService(_ businessService: HMBusinessService)
    func didCompleteBlockingBusinessService(_ businessService: HMBusinessService)

}
