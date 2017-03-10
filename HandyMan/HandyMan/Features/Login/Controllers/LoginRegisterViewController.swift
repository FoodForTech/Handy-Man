//
//  LoginRegisterViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/16/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class LoginRegisterViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailAddressTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
   
    // MARK: Internal Properties
    
    var userCredentials: UserCredentials?
    
    // MARK: Business Services
    
    private lazy var businessService: RegisterBusinessService = {
        return RegisterBusinessService(uiDelegate: self)
    }()
    
    // MARK: Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.emailAddressTextField.text = userCredentials?.emailAddress ?? ""
        self.passwordTextField.text = userCredentials?.password ?? ""
        
        self.firstNameTextField.becomeFirstResponder()
    }

    // MARK: IBActions
    
    @IBAction private func submit(_ sender: UIButton) {
        guard let firstName = self.firstNameTextField.text,
            let lastName = self.lastNameTextField.text,
            let emailAddress = self.emailAddressTextField.text,
            let password = self.passwordTextField.text else {
                return // TODO add validation
        }
    
        let user = User(id: 0, type: .issuer, firstName: firstName, lastName: lastName, emailAddress: emailAddress, phoneNumber: "544545454", assignToUserId: 2, assignToFirstName: "JohnGon", assignToLastName: "GonJohn")
        self.businessService.registerUser(user, password: password) {
            result in
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction private func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
