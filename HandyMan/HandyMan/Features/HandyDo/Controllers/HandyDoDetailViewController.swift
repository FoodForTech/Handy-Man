//
//  HandyDoDetailViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoDetailViewController: HMViewController {
    
    var handyDo: HandyDo = HandyDo()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = handyDo.title
        descriptionTextView.text = handyDo.todo
        statusLabel.text = handyDo.state()
    }

    // MARK: - Control Events
    
    @IBAction func complete(sender: UIButton) {
        handyDo.status = "3"
        self.handyDoBusinessService.updateHandyDo(handyDo)
    }
    
    @IBAction func inProgress(sender: UIButton) {
        handyDo.status = "2"
        self.handyDoBusinessService.updateHandyDo(handyDo)
    }
    
    // MARK: HandyDoBusinessService NavigationDelegate
    
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {}
    func didCreateHandyDo(businessService: HandyDoBusinessService) {}
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {}
    
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {
        self.navigationController?.popViewControllerAnimated(true)
    }
 
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()

}
