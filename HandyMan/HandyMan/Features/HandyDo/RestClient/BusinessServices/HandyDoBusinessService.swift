//
//  HandyDoBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class HandyDoBusinessService : HMBusinessService {
    
    weak var uiDelegate: HMBusinessServiceUIDelegate?
    
    fileprivate let createHandyDoService: CreateHandyDoService
    fileprivate let retrieveHandyDoService: RetrieveHandyDoService
    fileprivate let updateHandyDoService: UpdateHandyDoService
    fileprivate let deleteHandyDoService: DeleteHandyDoService
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
        self.createHandyDoService = CreateHandyDoService()
        self.retrieveHandyDoService = RetrieveHandyDoService()
        self.updateHandyDoService = UpdateHandyDoService()
        self.deleteHandyDoService = DeleteHandyDoService()
    }
    
    func createHandyDo(_ handyDo: HandyDo, completionHandler: @escaping (HMHandyDoResults) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.createHandyDoService.createHandyDo(handyDo,
            success: { response in
                completionHandler(.success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.failure(errors))
        })
    }
    
    func retrieveHandyDoList(_ assignmentType: AssignmentType, completionHandler: @escaping (HMHandyDoResults) -> Void) -> Void {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.retrieveHandyDoService.assignmentType = assignmentType
        self.retrieveHandyDoService.retrieveHandyDoList(
            success: { handyDoList in
                completionHandler(.items(handyDoList))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }
    
    func updateHandyDo(_ handyDo: HandyDo, completionHandler: @escaping (HMHandyDoResults) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.updateHandyDoService.updateHandyDo(handyDo,
            success: { response in
                completionHandler(.success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }
    
    func deleteHandyDo(_ handyDo: HandyDo, completionHandler: @escaping (HMHandyDoResults) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.deleteHandyDoService.deleteHandyDo(handyDo,
            success: { response in
                completionHandler(.success)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                completionHandler(.failure(errors))
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
        })
    }

}

enum AssignmentType : Int {
    
    case assignee = 0
    case assignTo
    
}

enum HMHandyDoResults {
    
    case success
    case items([HandyDo])
    case failure(NSError?)
    
//    func count() -> Int {
//        switch self {
//        case .Success:
//            
//        }
//        
//    }
    
}
