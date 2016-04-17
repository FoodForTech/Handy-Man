//
//  HMBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

protocol HMBusinessServiceUIDelegate {
    func willCallBlockingBusinessService(businessService: HMBusinessService)
    func didCompleteBlockingBusinessService(businessService: HMBusinessService)
}

class HMBusinessService {}
