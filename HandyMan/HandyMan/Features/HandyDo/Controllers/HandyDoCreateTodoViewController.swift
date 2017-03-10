//
//  HandyDoCreateTodoViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/13/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class HandyDoCreateTodoViewController: HMViewController, UIViewControllerTransitioningDelegate {
    
    fileprivate var handyDoList: HandyDoList = HandyDoList()
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Control Events
    
    @IBAction func create(_ sender: UIButton) {
        let handyDo = HandyDo(id: 0, title: titleField.text!, todo: descriptionTextView.text!, status: "1", dateTime: "")
        self.handyDoList.handyDoList.append(handyDo)
        self.handyDoBusinessService.createHandyDo(handyDo) { (result: HMHandyDoResults) in
            switch result {
            case HMHandyDoResults.success:
                break;
            case HMHandyDoResults.failure(_):
                break;
            default:
                break;
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
  
    // MARK: - Configuration
    
    func configure(handyDoList: HandyDoList) {
        self.modalPresentationStyle = .custom
        self.handyDoList = handyDoList
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()
    
}
