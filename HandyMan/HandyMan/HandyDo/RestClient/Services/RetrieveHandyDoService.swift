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
        let parameters = ["consumer_key":"5jvwMuSo2ofiAUCx0wNar7OvDlE8m22tpdGJXcYx"]
        HandyManRestClient.sharedInstance.getForService(self, parameters: parameters,
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
        let photos = json["photos"].array!
        for var i=0; i < photos.count; i++ {
            let camera = photos[i]["camera"].stringValue
            let category = photos[i]["category"].stringValue
            let description = photos[i]["description"].stringValue
            
            let handyDo: HandyDo = HandyDo(id:1, title: camera, todo: description, status: category)
            handyDoList.append(handyDo)
        }
        return handyDoList
    }
    
    // MARK: ServiceEndpoint Protocol
    
    override func serviceEndpoint() -> String {
        return "v1/photos"
    }
    
}
