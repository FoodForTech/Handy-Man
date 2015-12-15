//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: CommonViewController, LoginBusinessServiceNavigationDelegate, LoginBusinessServiceUIDelegate,  HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    
    struct Constants {
        static let HandyDoListViewControllerSegue: String = "HandyDoListViewControllerSegue"
    }
    
    var handyDoList: HandyDoList = HandyDoList()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Control Events
    
    @IBAction func logOn(sender: UIButton) {
        let emailAddress = userNameTextField.text!
        let password = passwordTextField.text!
        passwordTextField.text! = ""
        self.loginBusinessService.authorizeUserWithEmailAddress(emailAddress, password: password)
    }
    
    // MARK: - LoginBusinessService NavigationDelegate
    
    func didLoginWithBusinessService(service: LoginBusinessService, user: User) {
        userNameTextField.text! = ""
        self.handyDoBusinessService.retrieveHandyDoList()
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {}
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {}
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {}
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoListViewController: HandyDoListViewController = navigationController.topViewController as? HandyDoListViewController {
                handyDoListViewController.handyDoList = self.handyDoList
            }
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var loginBusinessService: LoginBusinessService = {
        let businessService = LoginBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
}
