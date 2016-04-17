//
//  HandyDoDetailViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoDetailViewController: HMViewController {
    
    var handyDo = HandyDo()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var completeButton: UIButton!
    @IBOutlet private weak var inProgressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        titleLabel.text = handyDo.title
        descriptionTextView.text = handyDo.todo
        statusLabel.text = handyDo.state()
        
        if handyDo.status == "2" {
            inProgressButton.hidden = true
        }
        if handyDo.status == "3" {
            completeButton.hidden = true
        }
    }

    // MARK: - Control Events
    
    @IBAction func complete(sender: UIButton) {
        handyDo.status = "3"
        self.handyDoBusinessService.updateHandyDo(handyDo) { response in
            self.didUpdateHandyDo()
        }
    }
    
    @IBAction func inProgress(sender: UIButton) {
        handyDo.status = "2"
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
