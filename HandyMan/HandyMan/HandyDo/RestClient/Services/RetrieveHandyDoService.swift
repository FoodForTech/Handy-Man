//
//  RetrieveHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//
import UIKit
import Alamofire

class RetrieveHandyDoService: AuthenticatedService {
    
    /**
     *   GET Retrieves HandyDo List 
     */
    func retrieveHandyDoList(success success:[HandyDo]->Void, failure:NSError? -> Void) -> Void {
        HandyManRestClient.sharedInstance.getForService(self,
            success: { (response) -> Void in
                success(self.mapModelToResponse(response!))
            },
            failure: {(errors) -> Void in
                failure(errors as? NSError)
            })
    }

    private func mapModelToResponse(response: Response<AnyObject, NSError>) -> [HandyDo] {
        let json = JSON(data: response.data!)
        
        var handyDoList: [HandyDo] = []
        let handyDos = json.array!
        for var i=0; i < handyDos.count; i++ {
            let handyDoId = handyDos[i]["id"].intValue
            let title = handyDos[i]["title"].stringValue
            let description = handyDos[i]["description"].stringValue
            let status = handyDos[i]["status"].stringValue
            
            let handyDo: HandyDo = HandyDo(id: handyDoId, title: title, todo: description, status: status)
            handyDoList.append(handyDo)
        }
        return handyDoList
    }
    
    // MARK: ServiceEndpoint Protocol
    
    override func serviceEndpoint() -> String {
        return "/v1/handyDo"
    }
    
}
