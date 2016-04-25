//
//  HandyDoList.swift
//  HandyMan
//
//  Created by Don Johnson on 12/14/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

// TODO redo data structure; it needs to be map an array to sectionRow data structure.

class HandyDoList {
    
    var handyDoList: [HandyDo]
    var handyDoSectionList: [[HandyDo]]
    
    init() {
        handyDoList = []
        handyDoSectionList = [[HandyDo]]()
    }
    
    func sortHandyDoListByStatus() {
        handyDoSectionList = [[HandyDo]]()
        var newHandyDoList = [HandyDo]()
        var inProgressHandyDoList = [HandyDo]()
        var completeHandyDoList = [HandyDo]()
        for handyDo: HandyDo in self.handyDoList {
            if handyDo.status == "1" {
                newHandyDoList.append(handyDo)
            } else if handyDo.status == "2" {
                inProgressHandyDoList.append(handyDo)
            } else if handyDo.status == "3" {
                completeHandyDoList.append(handyDo)
            }
        }
        self.handyDoSectionList.append(newHandyDoList)
        self.handyDoSectionList.append(inProgressHandyDoList)
        self.handyDoSectionList.append(completeHandyDoList)
    }
    
}
