//
//  HMUserManager.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

class HMUserManager {
    
    var id: Int {
        get {
            return self.user.id
        }
    }
    
    var firstName: String {
        get {
            return self.user.firstName
        }
    }
    
    var lastName: String {
        get {
            return self.user.lastName
        }
    }
    
    var emailAddress: String {
        get {
            return self.user.emailAddress
        }
    }
    
    var phoneNumber: String {
        get {
            return self.user.phoneNumber
        }
    }
    
    // Singleton implementation
    static let sharedInstance: HMUserManager = HMUserManager()
    private var user: User
    private init() {
        self.user = User()
    }
    
    func replaceEmptyUser(user: User) {
        if self.user.isEmpty() {
            self.user = user
        }
    }
    
    func logout() -> Void {
        self.user = User()
    }
    
}
