//
//  LoginRegisterViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/16/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    var userCredentials: UserCredentials?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        emailAddressTextField.text = userCredentials?.emailAddress ?? ""
        passwordTextField.text = userCredentials?.password ?? ""
    }

    // MARK: - Control Events
    
    @IBAction private func submit(sender: UIButton) {
        
        let user = User(id: 0, type: 1, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, emailAddress: emailAddressTextField.text!, phoneNumber: "1112223212", assignToFirstName: "John", assignToLastName: "Doe")
        
        self.businessService.registerUser(user, password: passwordTextField.text!) {
            result in
            
            print("Yay! New user")
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction private func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private lazy var businessService: RegisterBusinessService = {
        let businessService = RegisterBusinessService(uiDelegate: self)
        return businessService
    }()
    
}
