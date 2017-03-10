//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class LoginViewController: HMViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet fileprivate weak var userNameTextField: DesignableTextField!
    @IBOutlet fileprivate weak var passwordTextField: DesignableTextField!
    @IBOutlet private weak var logOnButton: SpringButton!
    @IBOutlet private weak var loginCredentialsView: SpringView!
    @IBOutlet private weak var brandingLabel: SpringLabel!
    
    // MARK: General Properties
    
    private var registerUserCredentials: UserCredentials?
    private var handyDoList = HandyDoList()
    
    // MARK: - Business Services
    
    private lazy var loginBusinessService: LoginBusinessService = {
        return LoginBusinessService(uiDelegate: self)
    }()
    
    private lazy var handyDoBusinessService: HandyDoBusinessService = {
        return HandyDoBusinessService(uiDelegate: self)
    }()
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.brandingLabel.isHidden = true
        delay(1.0) {
            self.brandingLabel.isHidden = false
            self.brandingLabel.animation = "slideLeft"
            self.brandingLabel.animate()
        }
    }
    
    // MARK: IBActions
    
    @IBAction private func logOn(_ sender: UIButton) {
        logOn()
    }
    
    @IBAction private func register(_ sender: UIButton) {
        guard let emailAddress = self.userNameTextField.text,
            let password = self.passwordTextField.text else {
                return
        }
        
        self.registerUserCredentials = UserCredentials(emailAddress: emailAddress, password: password)
        self.performSegue(withIdentifier: "LoginRegisterViewControllerSegue", sender: self)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            if let handyDoListViewController: HandyDoListViewController = navigationController.topViewController as? HandyDoListViewController {
                handyDoListViewController.configureWithHandyDoList(self.handyDoList)
                return
            }
        }
        if let loginRegisterViewController = segue.destination as? LoginRegisterViewController {
            loginRegisterViewController.userCredentials = registerUserCredentials
            return
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func logOn() {
        guard let userNameTextField = self.userNameTextField, var emailAddress = userNameTextField.text,
            let passwordTextField = self.passwordTextField, var password = passwordTextField.text else {
                return
        }
        
        self.decorate(userNameTextField, withBorderWidth: 0, usingColor: UIColor.black)
        self.decorate(passwordTextField, withBorderWidth: 0, usingColor: UIColor.black)
        let userCredentials = UserCredentials(emailAddress: emailAddress, password: password)
        if (userCredentials.isValid()) {
            self.loginBusinessService.authorizeUser(userCredentials) {
                (user: User) in
                
                if (user.isEmpty()) {
                    self.presentUIAlertController(LoginStrings.AuthErrorTitle.localized, message: LoginStrings.AuthErrorMessage.localized)
                } else {
                    emailAddress = ""
                    password = ""
                    self.handyDoBusinessService.retrieveHandyDoList(AssignmentType.assignee) {
                        handyDoList in
                        
                        switch handyDoList {
                        case .items(let handyDoList):
                            self.handyDoList.handyDoList = handyDoList
                            self.performSegue(withIdentifier: "HandyDoListViewControllerSegue", sender: self)
                        case .failure(_):
                            break;
                        default:
                            break;
                        }
                    }
                }
            }
        } else {
            loginCredentialsView.animateWithAnimation("shake")
            if emailAddress.isEmpty {
                decorate(self.userNameTextField, withBorderWidth: 2, usingColor: UIColor.red)
            }
            if password.isEmpty {
                decorate(self.passwordTextField, withBorderWidth: 2, usingColor: UIColor.red)
            }
        }
    }
    
    private func decorate(_ textField: DesignableTextField, withBorderWidth borderWidth: CGFloat, usingColor color: UIColor) {
        textField.borderWidth = borderWidth
        textField.borderColor = color
    }
    
    private func presentUIAlertController(_ title: String, message:String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIDevice.current.userInterfaceIdiom == .phone ? .actionSheet: .alert)
        let okAction = UIAlertAction(title: LoginStrings.AuthErrorOkButtonTitle.localized, style: .default) {
            (action: UIAlertAction) in
            
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: UITextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let emailAddress = self.userNameTextField?.text,
            let password = self.passwordTextField?.text else {
                return true
        }
        
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        if !emailAddress.isEmpty && !password.isEmpty {
            logOn()
            return true
        }
        return false
    }
    
}
