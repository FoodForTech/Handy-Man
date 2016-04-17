//
//  HMTableViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HMTableViewController : UITableViewController {

    let configurer = HMControllerConfigurer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial configuration
        configurer.setUpNavigationController(self.navigationController)
    }
    
}
