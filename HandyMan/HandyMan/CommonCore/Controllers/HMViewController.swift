//
//  HMViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HMViewController : UIViewController {
    
    let configurer = HMControllerConfigurer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial configuration
        configurer.setUpNavigationController(self.navigationController)
    }
    
}

extension UIViewController : HMBusinessServiceUIDelegate {
    
    // MARK: HMBusinessService UIDelegate
    
    // this seems to be locked and cannot be over written due to being in an extension of the main class ???  static dispatch rules...
    func willCallBlockingBusinessService(businessService: HMBusinessService) {
        view.showLoading()
    }
    
    func didCompleteBlockingBusinessService(businessService: HMBusinessService) {
        view.hideLoading()
    }
    
}
