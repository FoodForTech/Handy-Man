//
//  HandyDoDetailViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class HandyDoDetailViewController: HMViewController {
    
    fileprivate var handyDo = HandyDo()
    
    @IBOutlet fileprivate weak var descriptionTextView: UITextView!
    @IBOutlet fileprivate weak var inProgressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.text = handyDo.todo
        
        if handyDo.status == "1" {
            inProgressButton.setTitle("In Progress", for: UIControlState())
        } else if handyDo.status == "2" {
            inProgressButton.setTitle("Complete", for: UIControlState())
        } else {
            inProgressButton.isHidden = true;
        }
    }

    func configure(handyDo: HandyDo) {
        self.handyDo = handyDo
    }
    
    // MARK: - Control Events
    
    @IBAction func inProgress(_ sender: UIButton) {
        if handyDo.status == "1" {
            handyDo.status = "2"
        } else if handyDo.status == "2" {
            handyDo.status = "3"
        }
        self.handyDoBusinessService.updateHandyDo(handyDo) { response in
            self.didUpdateHandyDo()
        }
    }
    
    // MARK - Helper Methods
    
    fileprivate func didUpdateHandyDo() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()

}
