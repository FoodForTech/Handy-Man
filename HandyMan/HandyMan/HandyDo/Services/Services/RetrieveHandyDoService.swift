//
//  RetrieveHandyDoService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class RetrieveHandyDoService: NSObject {

    func retrieveHandyDoList()->[HandyDo] {
        var handyDoList = Array<HandyDo>()
        for var i = 0; i<10; i++ {
            let handyDo = HandyDo(title: "title", todo: "todo", status: "status")
            handyDoList.append(handyDo)
        }
        return handyDoList
    }
    
}
