//
//  HandyDoCreateTodoViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/13/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoCreateTodoViewController: UIViewController, HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {

    var handyDoList: [HandyDo] = [HandyDo]()
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Control Events
    
    @IBAction func create(sender: UIButton) {
        let handyDo = HandyDo(id: 0, title: titleField.text!, todo: descriptionField.text!, status: "1", dateTime: "")
        self.handyDoList.append(handyDo)
        self.handyDoBusinessService.createHandyDo(handyDo)
    }
    
    @IBAction func done(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {
        // append to list and dismiss
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {}
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {}
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {}
    
    
    // MARK: Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
    
}
