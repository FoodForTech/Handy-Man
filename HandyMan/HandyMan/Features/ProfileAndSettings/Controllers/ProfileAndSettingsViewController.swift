//
//  ProfileAndSettingsViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/18/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class ProfileAndSettingsViewController: HMViewController {
    
    @IBOutlet private weak var userImageField: DesignableImageView!
    @IBOutlet private weak var firstNameLabel: UITextField!
    @IBOutlet private weak var lastNameField: UITextField!
    @IBOutlet private weak var emailAddressField: UITextField!
    @IBOutlet private weak var phoneNumberField: UITextField!
    @IBOutlet weak var imageContainerView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageContainerView.layer.cornerRadius = self.imageContainerView.frame.size.width / 2.0
        self.imageContainerView.clipsToBounds = true
        self.imageContainerView.layer.borderWidth = 2
        self.imageContainerView.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.firstNameLabel.text = HMUserManager.sharedInstance.firstName
        self.lastNameField.text = HMUserManager.sharedInstance.lastName
        self.emailAddressField.text = HMUserManager.sharedInstance.emailAddress
        self.phoneNumberField.text = HMUserManager.sharedInstance.phoneNumber
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.userImageField.image = UIImage(named: "DonJohnson_rs")
        self.userImageField.animation = "slideLeft"
        self.userImageField.animate()
        
        delay(3.0) {
            self.userImageField.image = UIImage(named: "blank_person")
            self.userImageField.animation = "slideRight"
            self.userImageField.animate()
        }
        
    }
    
    // MARK: - Control Events
    
    @IBAction func deleteAccount(sender: UIButton) {
        // TODO
        print("deleteAccount")
    }
    
    @IBAction func logout(sender: UIButton) {
        HMUserManager.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
