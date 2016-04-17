//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: HMViewController {
    
    private struct Constants {
        static let LoginRegisterViewControllerSegue = "LoginRegisterViewControllerSegue"
        static let HandyDoListViewControllerSegue = "HandyDoListViewControllerSegue"
        static let LoginErrorTitle = "Missing Required Info"
        static let LoginErrorMessage = "Both the email and password are required to access your accounts."
        static let AuthErrorTitle = "Authentication Failed"
        static let AuthErrorMessage = "Your credentials cannot be authenticated.  Please try again."
        static let AuthErrorOkButtonTitle = "OK"
    }
    
    var handyDoList = HandyDoList()
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Control Events
    
    @IBAction private func logOn(sender: UIButton) {
        let emailAddress = userNameTextField.text!
        let password = passwordTextField.text!
        let userCredentials = UserCredentials(emailAddress: emailAddress, password: password)
        if (userCredentials.isValid()) {
            self.loginBusinessService.authorizeUser(userCredentials, completionHandler: { user in
                if (user.isEmpty()) {
                    self.presentUIAlertControllerWithTitle(Constants.AuthErrorTitle, message: Constants.AuthErrorMessage)
                } else {
                    self.userNameTextField.text! = ""
                    self.passwordTextField.text! = ""
                    self.handyDoBusinessService.retrieveHandyDoList(AssignmentType.Assignee, completionHandler: { handyDoList in
                        self.handyDoList.handyDoList = handyDoList
                        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
                    })
                }
            })
        } else {
            self.presentUIAlertControllerWithTitle(Constants.LoginErrorTitle, message: Constants.LoginErrorMessage)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoListViewController: HandyDoListViewController = navigationController.topViewController as? HandyDoListViewController {
                handyDoListViewController.configureWithHandyDoList(self.handyDoList)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func presentUIAlertControllerWithTitle(title: String, message:String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: Constants.AuthErrorOkButtonTitle, style: .Default, handler: { alert in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Lazy Loaded Properties
    
    private lazy var loginBusinessService: LoginBusinessService = {
        let businessService = LoginBusinessService(uiDelegate: self)
        return businessService
    }()
    
    private lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()
    
}
