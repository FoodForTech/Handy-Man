//
//  RetrieveHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//
import UIKit
import Alamofire
import Freddy

final class RetrieveHandyDoService: HMAuthenticatedService {
    
    var assignmentType: AssignmentType = AssignmentType(rawValue: 0)!
    
    /**
     *   GET Retrieves HandyDo List
     */
    func retrieveHandyDoList(success: @escaping ([HandyDo]) -> Void, failure: @escaping (NSError?) -> Void) -> Void {
        HMRestClient.getForService(self,
           success: {
            (response: DataResponse<Any>?) in
           
            do {
                success(try self.mapModel(from: response!))
            } catch {
                failure(NSError(domain: "domain", code: 400, userInfo: nil))
            }
        }, failure: {
           errors in
                                    
           failure(errors as? NSError)
        })
    }
    
    // MARK: ServiceEndpoint Protocol
    
    func serviceEndpoint() -> String {
        switch self.assignmentType {
        case .assignee:
            return "/v1/handyDo/\(HMUserManager.sharedInstance.id)/assignee"  // TODO remove user.id dependency this should be passed in.
        case .assignTo:
            return "/v1/handyDo/\(HMUserManager.sharedInstance.id)/assign_to"
        }
    }
    
    // MARK: - Helper Methods
    
    private func mapModel(from response: DataResponse<Any>) throws -> [HandyDo] {
        
        if let data = response.data {
            let json = try JSON(data: data)
            let handyDoList = try json.getArray().map(HandyDo.init)
            return handyDoList
        }
        return [HandyDo()]
        
    }

}
