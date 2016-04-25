//
//  HandyDoCreateTodoViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/13/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoCreateTodoViewController: HMViewController {
    
    private var handyDoList: HandyDoList = HandyDoList()
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Control Events
    
    @IBAction func create(sender: UIButton) {
        let handyDo = HandyDo(id: 0, title: titleField.text!, todo: descriptionTextView.text!, status: "1", dateTime: "")
        self.handyDoList.handyDoList.append(handyDo)
        self.handyDoBusinessService.createHandyDo(handyDo) { (result: HMHandyDoResults) in
            switch result {
            case HMHandyDoResults.Success:
                break;
            case HMHandyDoResults.Failure(_):
                break;
            default:
                break;
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func done(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    // MARK: - Configuration
    
    func configure(handyDoList handyDoList: HandyDoList) {
        self.handyDoList = handyDoList
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()
    
}
