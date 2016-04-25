//
//  HandyDoDetailViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoDetailViewController: HMViewController {
    
    private var handyDo = HandyDo()
    
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var inProgressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.text = handyDo.todo
        
        if handyDo.status == "1" {
            inProgressButton.setTitle("In Progress", forState: UIControlState.Normal)
        } else if handyDo.status == "2" {
            inProgressButton.setTitle("Complete", forState: UIControlState.Normal)
        } else {
            inProgressButton.hidden = true;
        }
    }

    func configure(handyDo handyDo: HandyDo) {
        self.handyDo = handyDo
    }
    
    // MARK: - Control Events
    
    @IBAction func inProgress(sender: UIButton) {
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
    
    private func didUpdateHandyDo() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()

}
