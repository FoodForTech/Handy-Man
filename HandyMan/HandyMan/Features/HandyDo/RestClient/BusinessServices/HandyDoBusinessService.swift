//
//  HandyDoBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoBusinessService : HMBusinessService {
    
    weak var uiDelegate: HMBusinessServiceUIDelegate?
    
    private let createHandyDoService: CreateHandyDoService
    private let retrieveHandyDoService: RetrieveHandyDoService
    private let updateHandyDoService: UpdateHandyDoService
    private let deleteHandyDoService: DeleteHandyDoService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        self.createHandyDoService = CreateHandyDoService()
        self.retrieveHandyDoService = RetrieveHandyDoService()
        self.updateHandyDoService = UpdateHandyDoService()
        self.deleteHandyDoService = DeleteHandyDoService()
    }
    
    func createHandyDo(handyDo: HandyDo, completionHandler: HMHandyDoResults -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.createHandyDoService.createHandyDo(handyDo,
            success: { response in
                completionHandler(.Success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.Failure(errors))
        })
    }
    
    func retrieveHandyDoList(assignmentType: AssignmentType, completionHandler: HMHandyDoResults -> Void) -> Void {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.retrieveHandyDoService.assignmentType = assignmentType
        self.retrieveHandyDoService.retrieveHandyDoList(
            success: { handyDoList in
                completionHandler(.Items(handyDoList))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.Failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }
    
    func updateHandyDo(handyDo: HandyDo, completionHandler: HMHandyDoResults -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.updateHandyDoService.updateHandyDo(handyDo,
            success: { response in
                completionHandler(.Success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.Failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }
    
    func deleteHandyDo(handyDo: HandyDo, completionHandler: HMHandyDoResults -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.deleteHandyDoService.deleteHandyDo(handyDo,
            success: { response in
                completionHandler(.Success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.Failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }

}

enum AssignmentType : Int {
    
    case Assignee = 0
    case AssignTo
    
}

enum HMHandyDoResults {
    
    case Success
    case Items([HandyDo])
    case Failure(NSError?)
    
//    func count() -> Int {
//        switch self {
//        case .Success:
//            
//        }
//        
//    }
    
}
