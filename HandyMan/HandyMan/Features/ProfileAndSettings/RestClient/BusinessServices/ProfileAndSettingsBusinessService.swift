//
//  ProfileAndSettingsBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/18/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

final class ProfileAndSettingsBusinessService: HMBusinessService {
    
    weak var uiDelegate: HMBusinessServiceUIDelegate?
    
    required init(uiDelegate: HMBusinessServiceUIDelegate?) {
        self.uiDelegate = uiDelegate
    }
}
