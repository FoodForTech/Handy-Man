//
//  HandyDo.swift
//  HandyMan
//
//  Created by Don Johnson on 12/7/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

class HandyDo {

    var id: Int
    var title: String
    var todo: String
    var status: String
    var dateTime: String

    // MARK: Init
    
    init() {
        self.id = 0
        self.title = ""
        self.todo = ""
        self.status = ""
        self.dateTime = ""
    }
    
    init(id: Int, title: String, todo: String, status: String, dateTime: String) {
        self.id = id
        self.title = title
        self.todo = todo
        self.status = status
        self.dateTime = dateTime
    }
    
    // Internal Helper Methods
    
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
