//
//  ProfileAndSettingsViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/18/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class ProfileAndSettingsViewController: CommonViewController {
    @IBOutlet weak var userImageField: UIImageView!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.userImageField.image = UIImage(named: "DonJohnson_rs")
        self.userImageField.layer.cornerRadius = 50
        self.userImageField.clipsToBounds = true
        self.userImageField.layer.borderColor = UIColor.whiteColor().CGColor
        self.userImageField.layer.borderWidth = 2
        
        self.firstNameLabel.text = UserManager.sharedInstance.user.firstName
        self.lastNameField.text = UserManager.sharedInstance.user.lastName
        self.emailAddressField.text = UserManager.sharedInstance.user.emailAddress
        self.phoneNumberField.text = UserManager.sharedInstance.user.phoneNumber
    }
    
    // MARK: - Control Events
    
    @IBAction func deleteAccount(sender: UIButton) {
        print("deleteAccount")
    }
    
    @IBAction func logout(sender: UIButton) {
        UserManager.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
