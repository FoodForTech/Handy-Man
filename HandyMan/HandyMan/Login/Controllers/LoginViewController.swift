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
        self.handyDoBusinessService.retrieveHandyDoList()
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {
        self.handyDoList = handyDoList
        self .performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    // MARK: - HandyDoBusinessService UIDelegate
    
    func didCallBlockingService(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    func didCompleteBlockingService(businessService: HandyDoBusinessService) {
        // left intentionally blank
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let handyDoListViewController = segue.destinationViewController as? HandyDoListViewController {
            handyDoListViewController.handyDoList = self.handyDoList
            self.navigationController?.pushViewController(handyDoListViewController, animated: true)
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
    
}
