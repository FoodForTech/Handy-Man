//
//  HandyDoBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

protocol HandyDoBusinessServiceNavigationDelegate {
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) -> Void
}

protocol HandyDoBusinessServiceUIDelegate {
    func didCallBlockingService(businessService: HandyDoBusinessService) -> Void
    func didCompleteBlockingService(businessService: HandyDoBusinessService) -> Void
}

class HandyDoBusinessService: NSObject {
    let navigationDelegate: HandyDoBusinessServiceNavigationDelegate
    let uiDelegate: HandyDoBusinessServiceUIDelegate
    let retrieveHandyDoService: RetrieveHandyDoService
    
    init(navigationDelegate: HandyDoBusinessServiceNavigationDelegate, uiDelegate: HandyDoBusinessServiceUIDelegate) {
        self.navigationDelegate = navigationDelegate
        self.uiDelegate = uiDelegate
        self.retrieveHandyDoService = RetrieveHandyDoService();
    }
    
    func retrieveHandyDoList() -> Void {
        self.uiDelegate.didCallBlockingService(self)
        let handyDoList: [HandyDo] = self.retrieveHandyDoService.retrieveHandyDoList()
        self.navigationDelegate.didRetrieveHandyDoList(self, handyDoList: handyDoList)
        self.uiDelegate.didCompleteBlockingService(self)
    }
}
