//
//  HandyDoBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

protocol HandyDoBusinessServiceNavigationDelegate {
    func didCreateHandyDo(businessService: HandyDoBusinessService) -> Void
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) -> Void
    func didUpdateHandyDo(businessService: HandyDoBusinessService) -> Void
    func didDeleteHandyDo(businessService: HandyDoBusinessService) -> Void
}

protocol HandyDoBusinessServiceUIDelegate {
    func didCallBlockingServiceWithBusinessService(businessService: HandyDoBusinessService) -> Void
    func didCompleteBlockingServiceWithBusinessService(businessService: HandyDoBusinessService) -> Void
}

class HandyDoBusinessService: NSObject {
    let navigationDelegate: HandyDoBusinessServiceNavigationDelegate
    let uiDelegate: HandyDoBusinessServiceUIDelegate
    let createHandyDoService: CreateHandyDoService
    let retrieveHandyDoService: RetrieveHandyDoService
    let updateHandyDoService: UpdateHandyDoService
    let deleteHandyDoService: DeleteHandyDoService
    
    init(navigationDelegate: HandyDoBusinessServiceNavigationDelegate, uiDelegate: HandyDoBusinessServiceUIDelegate) {
        self.navigationDelegate = navigationDelegate
        self.uiDelegate = uiDelegate
        self.createHandyDoService = CreateHandyDoService()
        self.retrieveHandyDoService = RetrieveHandyDoService()
        self.updateHandyDoService = UpdateHandyDoService()
        self.deleteHandyDoService = DeleteHandyDoService()
    }
    
    func createHandyDo(handyDo: HandyDo) {
        self.uiDelegate.didCallBlockingServiceWithBusinessService(self)
        self.createHandyDoService.createHandyDo(handyDo,
            success: { (NSURLResponse) -> Void in
                // success
                self.navigationDelegate.didCreateHandyDo(self)
                self.uiDelegate.didCompleteBlockingServiceWithBusinessService(self)
            },
            failure: {(NSError) -> Void in
                // failure
                // should call failure delegation
        })
    }
    
    func retrieveHandyDoList() -> Void {
        self.uiDelegate.didCallBlockingServiceWithBusinessService(self)
        self.retrieveHandyDoService.retrieveHandyDoList(
            success: { (handyDoList) -> Void in
                self.navigationDelegate.didRetrieveHandyDoList(self, handyDoList: handyDoList)
                self.uiDelegate.didCompleteBlockingServiceWithBusinessService(self)
            },
            failure: {(nsError) -> Void in
                // failure call failure delegation
        })
    }
    
    func updateHandyDo(handyDo: HandyDo) {
        self.uiDelegate.didCallBlockingServiceWithBusinessService(self)
        
        self.updateHandyDoService.updateHandyDo(handyDo,
            success: {(response) -> Void in
                self.navigationDelegate.didUpdateHandyDo(self)
                self.uiDelegate.didCompleteBlockingServiceWithBusinessService(self)
            },
            failure: { (nsError) -> Void in
                // failure call failure delegation
        })
    }
    
    func deleteHandyDo(handyDo: HandyDo) {
        self.uiDelegate.didCallBlockingServiceWithBusinessService(self)
        
        self.deleteHandyDoService.deleteHandyDo(handyDo,
            success: {(response) -> Void in
                self.navigationDelegate.didDeleteHandyDo(self)
                self.uiDelegate.didCompleteBlockingServiceWithBusinessService(self)
            },
            failure: {(error) -> Void in
                // failure call failure delegation
        })
    }
    
}
