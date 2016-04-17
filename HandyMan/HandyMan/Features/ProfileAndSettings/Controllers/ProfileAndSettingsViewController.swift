//
//  ProfileAndSettingsViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/18/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class ProfileAndSettingsViewController: HMViewController {
    
    @IBOutlet weak var userImageField: UIImageView!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImageField.image = UIImage(named: "DonJohnson_rs")
        self.userImageField.layer.cornerRadius = 50
        self.userImageField.clipsToBounds = true
        self.userImageField.layer.borderColor = UIColor.whiteColor().CGColor
        self.userImageField.layer.borderWidth = 2
        
        self.firstNameLabel.text = HMUserManager.sharedInstance.user.firstName
        self.lastNameField.text = HMUserManager.sharedInstance.user.lastName
        self.emailAddressField.text = HMUserManager.sharedInstance.user.emailAddress
        self.phoneNumberField.text = HMUserManager.sharedInstance.user.phoneNumber
    }
    
    // MARK: - Control Events
    
    @IBAction func deleteAccount(sender: UIButton) {
        print("deleteAccount")
    }
    
    @IBAction func logout(sender: UIButton) {
        HMUserManager.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
