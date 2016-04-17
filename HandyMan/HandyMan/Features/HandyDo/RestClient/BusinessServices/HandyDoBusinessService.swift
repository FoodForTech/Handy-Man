//
//  HandyDoBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

enum AssignmentType : Int {
    
    case Assignee = 0
    case AssignTo
    
}

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
    
    func createHandyDo(handyDo: HandyDo, completionHandler:(Bool) -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.createHandyDoService.createHandyDo(handyDo,
            success: { response in
                completionHandler(response)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                // TODO failure call failure delegation
        })
    }
    
    func retrieveHandyDoList(assignmentType: AssignmentType, completionHandler:[HandyDo] -> Void) -> Void {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.retrieveHandyDoService.assignmentType = assignmentType
        self.retrieveHandyDoService.retrieveHandyDoList(
            success: { handyDoList in
                completionHandler(handyDoList)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                // TODO failure call failure delegation
        })
    }
    
    func updateHandyDo(handyDo: HandyDo, completionHandler:Bool -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.updateHandyDoService.updateHandyDo(handyDo,
            success: { response in
                completionHandler(response)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                // TODO failure call failure delegation
        })
    }
    
    func deleteHandyDo(handyDo: HandyDo, completionHandler:Bool -> Void) {
        self.uiDelegate?.willCallBlockingBusinessService(self)
        self.deleteHandyDoService.deleteHandyDo(handyDo,
            success: { response in
                completionHandler(response)
                self.uiDelegate?.didCompleteBlockingBusinessService(self)
            },
            failure: { errors in
                // TODO failure call failure delegation
        })
    }
    
}
