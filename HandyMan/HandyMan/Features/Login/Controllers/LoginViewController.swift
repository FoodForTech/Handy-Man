//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: HMViewController, UITextFieldDelegate {
    
    private struct Constants {
        static let LoginRegisterViewControllerSegue = "LoginRegisterViewControllerSegue"
        static let HandyDoListViewControllerSegue = "HandyDoListViewControllerSegue"
        static let LoginErrorTitle = "Missing Required Info"
        static let LoginErrorMessage = "Both the email and password are required to access your accounts."
        static let AuthErrorTitle = "Authentication Failed"
        static let AuthErrorMessage = "Your credentials cannot be authenticated.  Please try again."
        static let AuthErrorOkButtonTitle = "OK"
    }
    
    private let colors = [UIColor.blackColor(), UIColor.blueColor(), UIColor.brownColor(), UIColor.whiteColor()]
    private var i = 0
    
    private var registerUserCredentials: UserCredentials?
    private var handyDoList = HandyDoList()
    
    @IBOutlet private weak var userNameTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var logOnButton: SpringButton!
    @IBOutlet weak var loginCredentialsView: SpringView!
    @IBOutlet weak var brandingLabel: SpringLabel!
    @IBOutlet weak var objectToAnimate: DesignableView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        delay(1.5) {
            self.brandingLabel.animation = "slideLeft"
            self.brandingLabel.animate()
            self.animateBranding()
        }
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        let emailAddress = userNameTextField.text!
        let password = userNameTextField.text!
        if !emailAddress.isEmpty && !password.isEmpty {
            self.logOn()
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoListViewController: HandyDoListViewController = navigationController.topViewController as? HandyDoListViewController {
                handyDoListViewController.configureWithHandyDoList(self.handyDoList)
                return
            }
        }
        if let loginRegisterViewController = segue.destinationViewController as? LoginRegisterViewController {
            loginRegisterViewController.userCredentials = registerUserCredentials
            return
        }
    }
    
    // MARK: - Control Events
    
    @IBAction private func logOn(sender: UIButton) {
        self.logOn()
    }
    
    func animateBranding() {
        let translate = CGAffineTransformMakeTranslation(350, 0)
        let scale = CGAffineTransformMakeScale(0.62, 0.62)
        self.objectToAnimate.transform = CGAffineTransformConcat(translate, scale)
        
        UIView.animateWithDuration(NSTimeInterval(3.0), delay: NSTimeInterval(0.0), options: [.CurveEaseInOut], animations: {
            self.objectToAnimate.transform = CGAffineTransformIdentity
                delay(2.0) {
                    UIView.animateWithDuration(1.0, animations: {
                        let translate = CGAffineTransformMakeTranslation(-350, 0)
                        let scale = CGAffineTransformMakeScale(0.62, 0.62)
                        self.objectToAnimate.transform = CGAffineTransformConcat(translate, scale)
                        }, completion: { finished in
                        delay(2.0) {
                            if self.i == self.colors.count {
                                self.i=0
                            }
                            self.objectToAnimate.backgroundColor = self.colors[self.i]
                            self.animateBranding()
                            self.i+=1
                        }
                    
                    })
                }
            }, completion: nil)
        
    }
    
    @IBAction func register(sender: UIButton) {
        let emailAddress = self.userNameTextField.text!
        let password = self.passwordTextField.text!
        registerUserCredentials = UserCredentials(emailAddress: emailAddress, password: password)
        if !emailAddress.isEmpty {
            self.performSegueWithIdentifier(Constants.LoginRegisterViewControllerSegue, sender: self)
        } else {
            loginCredentialsView.animateWithAnimation("swing")
        }
    }
    
    // MARK: - Helper Methods
    
    private func logOn() {
        self.decorate(self.userNameTextField, borderWidth: 0, color: UIColor.blackColor())
        self.decorate(self.passwordTextField, borderWidth: 0, color: UIColor.blackColor())
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
                    self.handyDoBusinessService.retrieveHandyDoList(AssignmentType.Assignee, completionHandler: {
                        handyDoList in
                        
                        switch handyDoList {
                        case .Items(let handyDoList):
                            self.handyDoList.handyDoList = handyDoList
                            self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
                        case .Failure(_):
                            break;
                        default:
                            break;
                        }
                    })
                }
            })
        } else {
            loginCredentialsView.animateWithAnimation("shake")
            if emailAddress.isEmpty {
                decorate(self.userNameTextField, borderWidth: 2, color: UIColor.redColor())
            }
            if password.isEmpty {
                decorate(self.passwordTextField, borderWidth: 2, color: UIColor.redColor())
            }
        }
    }
    
    private func decorate(textField: DesignableTextField, borderWidth: CGFloat, color: UIColor) {
        textField.borderWidth = borderWidth
        textField.borderColor = color
    }
    
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
