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
    
    // MOCK UP of data TODO link to real service
    
    func retrieveHandyDoList(success success:[HandyDo]->Void, failure:NSError? -> Void) -> Void {
        Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters: ["consumer_key": "5jvwMuSo2ofiAUCx0wNar7OvDlE8m22tpdGJXcYx"]).responseJSON() {(response) in
            switch response.result {
            case .Success:
                print(response.result.value)
                success(self.mapModelToResponse(response))
            case .Failure:
                print(response.result.error)
            }
        }
    }
    
    // get request from Alamofire and tjhen map the son to model using SwiftyJSON.
    // I need to research how to do authentication.  Alamofire supports several good ones.
    
    func mapModelToResponse(response: Response<AnyObject, NSError>) -> [HandyDo] {
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
    
    // MOCK UP
//    Alamofire.request(.GET, "https://www.google.com/").responseJSON { (response) -> Void in
//    switch response.result {
//    case .Success:
//    var handyDoList = Array<HandyDo>()
//    for var i = 0; i<10; i++ {
//    var handyDo: HandyDo
//    if (i % 2 == 0) {
//    handyDo = HandyDo(id: 1, title: "title", todo: "todo", status: "new")
//    } else {
//    handyDo = HandyDo(id: 2, title: "title2", todo: "todo2", status: "complete")
//    }
//    handyDoList.append(handyDo)
//    }
//    success(handyDoList)
//    case .Failure:
//    failure(response.result.error)
//    }
//    }
    
    
    
}
