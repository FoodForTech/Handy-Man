//
//  UIViewController_CommonBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

// MARK: CommonBusinessService Extension

extension UIViewController {
    
    // MARK: CommonBusinessService UIDelegate
    
    func willCallBlockingBusinessService(businessService: CommonBusinessService) {
        print("willCallBlockingBusinessService:")
    }
    
    func didCompleteBlockingBusinessService(businessService: CommonBusinessService) {
        print("didCompleteBlockingBusinessService:")
    }
    
}
