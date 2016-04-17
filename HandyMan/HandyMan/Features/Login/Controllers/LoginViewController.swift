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
        static let LoginRegisterViewControllerSegue: String = "LoginRegisterViewControllerSegue"
        static let HandyDoListViewControllerSegue: String = "HandyDoListViewControllerSegue"
        static let LoginErrorTitle: String = "Missing Required Info"
        static let LoginErrorMessage: String = "Both the email and password are required to access your accounts."
        static let AuthErrorTitle: String = "Authentication Failed"
        static let AuthErrorMessage: String = "Your credentials cannot be authenticated.  Please try again."
    }
    
    var handyDoList: HandyDoList = HandyDoList()
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Control Events
    
    @IBAction private func logOn(sender: UIButton) {
        let emailAddress = userNameTextField.text!
        let password = passwordTextField.text!
        if (emailAddress.isEmpty || password.isEmpty) {
            self.presentUIAlertControllerWithTitle(Constants.LoginErrorTitle, message: Constants.LoginErrorMessage)
        } else {
            self.loginBusinessService.authorizeUserWithEmailAddress(emailAddress, password: password, completionHandler: { user in
                self.didLoginWithUser(user)
            })
        }
    }
    
    func didLoginWithUser(user: User) {
        if (user.isEmpty()) {
            self.presentUIAlertControllerWithTitle(Constants.AuthErrorTitle, message: Constants.AuthErrorMessage)
        } else {
            userNameTextField.text! = ""
            passwordTextField.text! = ""
            self.handyDoBusinessService.retrieveHandyDoList(AssignmentType.Assignee, completionHandler: { handyDoList in
                self.didRetrieveHandyDoList(handyDoList)
            })
        }
    }
    
    func didRetrieveHandyDoList(handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
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
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: { alert in
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
