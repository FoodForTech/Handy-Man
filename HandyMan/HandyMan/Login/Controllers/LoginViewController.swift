//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: CommonViewController, LoginBusinessServiceNavigationDelegate, LoginBusinessServiceUIDelegate,  HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    
    private struct Constants {
        static let kLoginRegisterViewControllerSegue: String = "LoginRegisterViewControllerSegue"
        static let kHandyDoListViewControllerSegue: String = "HandyDoListViewControllerSegue"
        static let kLoginErrorTitle: String = "Missing Required Info"
        static let kLoginErrorMessage: String = "Both the email and password are required to access your accounts."
        static let kAuthErrorTitle: String = "Authentication Failed"
        static let kAuthErrorMessage: String = "Your credentials cannot be authenticated.  Please try again."
    }
    
    var handyDoList: HandyDoList = HandyDoList()
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: - Control Events
    
    @IBAction private func logOn(sender: UIButton) {
        let emailAddress = userNameTextField.text!
        let password = passwordTextField.text!
        if (emailAddress.isEmpty || password.isEmpty) {
            self.presentUIAlertControllerWithTitle(Constants.kLoginErrorTitle, message: Constants.kLoginErrorMessage)
        } else {
            self.loginBusinessService.authorizeUserWithEmailAddress(emailAddress, password: password)
        }
    }
    
    // MARK: - LoginBusinessService NavigationDelegate
    
    func didLoginWithBusinessService(service: LoginBusinessService, user: User) {
        if (user.isEmpty()) {
            self.presentUIAlertControllerWithTitle(Constants.kAuthErrorTitle, message: Constants.kAuthErrorMessage)
        } else {
            userNameTextField.text! = ""
            passwordTextField.text! = ""
            self.handyDoBusinessService.retrieveHandyDoList(AssignmentType.Assignee)
        }
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {}
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {}
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {}
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.performSegueWithIdentifier(Constants.kHandyDoListViewControllerSegue, sender: self)
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
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Lazy Loaded Properties
    
    private lazy var loginBusinessService: LoginBusinessService = {
        let businessService = LoginBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
    private lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
}
