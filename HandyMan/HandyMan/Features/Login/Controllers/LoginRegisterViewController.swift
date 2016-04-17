//
//  LoginRegisterViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/16/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Control Events
    
    @IBAction func submit(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
