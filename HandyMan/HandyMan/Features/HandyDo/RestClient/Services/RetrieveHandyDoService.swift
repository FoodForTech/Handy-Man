//
//  RetrieveHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//
import UIKit
import Alamofire

class RetrieveHandyDoService: HMAuthenticatedService {
    
    var assignmentType: AssignmentType = AssignmentType(rawValue: 0)!
    
    /**
     *   GET Retrieves HandyDo List
     */
    func retrieveHandyDoList(success success:[HandyDo]->Void, failure:NSError? -> Void) -> Void {
        HMRestClient.sharedInstance.getForService(self,
            success: { response in
                success(self.mapModelToResponse(response!))
            },
            failure: { errors in
                failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceEndpoint Protocol
    
    func serviceEndpoint() -> String {
        switch self.assignmentType {
        case .Assignee:
            return "/v1/handyDo/\(HMUserManager.sharedInstance.user.id)/assignee"
        case .AssignTo:
            return "/v1/handyDo/\(HMUserManager.sharedInstance.user.id)/assign_to"
        }
    }
    
    // MARK: - Helper Methods
    
    private func mapModelToResponse(response: Response<AnyObject, NSError>) -> [HandyDo] {
        let json = JSON(data: response.data!)
        
        var handyDoList: [HandyDo] = []
        let handyDos = json.array!
        for i in 0..<handyDos.count {
            let handyDoId = handyDos[i]["id"].intValue
            let title = handyDos[i]["title"].stringValue
            let description = handyDos[i]["description"].stringValue
            let status = handyDos[i]["status"].stringValue
            let dateTime = handyDos[i]["date_time"].stringValue
            
            let handyDo: HandyDo = HandyDo(id: handyDoId, title: title, todo: description, status: status, dateTime: dateTime)
            handyDoList.append(handyDo)
        }
        return handyDoList
    }
}
