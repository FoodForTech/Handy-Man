//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    
    struct Constants {
        static let HandyDoListViewControllerSegue: String = "HandyDoListViewControllerSegue"
    }
    
    var handyDoList: [HandyDo] = []
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Control Events
    
    @IBAction func logOn(sender: UIButton) {
        // TODO authentication
        self.handyDoBusinessService.retrieveHandyDoList()
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {
        self.handyDoList = handyDoList
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    // MARK: - HandyDoBusinessService UIDelegate
    
    func didCallBlockingServiceWithBusinessService(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    func didCompleteBlockingServiceWithBusinessService(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoListViewController: HandyDoListViewController = navigationController.topViewController as? HandyDoListViewController {
                handyDoListViewController.handyDoList = self.handyDoList
            }
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
}
