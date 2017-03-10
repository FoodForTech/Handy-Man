//
//  HMBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

protocol HMBusinessService: class {

    weak var uiDelegate: HMBusinessServiceUIDelegate? { get }
    
    init(uiDelegate: HMBusinessServiceUIDelegate?)
    
}
