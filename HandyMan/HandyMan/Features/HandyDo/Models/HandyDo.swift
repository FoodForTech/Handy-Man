//
//  HandyDo.swift
//  HandyMan
//
//  Created by Don Johnson on 12/7/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

class HandyDo {

    let id: Int
    
    var title: String
    var todo: String
    var dateTime: String
    var status: String
    
    init(id: Int = 0, title: String = "", todo: String = "", status: String = "", dateTime: String = "") {
        self.id = id
        self.title = title
        self.todo = todo
        self.status = status
        self.dateTime = dateTime
    }
    
    func state() -> String {
        if status == "1" {
            return "New"
        } else if status == "2" {
            return "In Progress"
        } else if status == "3" {
            return "Complete"
        }
        return "Unknown"
    }
    
    // TODO
    func formattedDate() -> String {
        return "12/14/15"
    }
    
}
