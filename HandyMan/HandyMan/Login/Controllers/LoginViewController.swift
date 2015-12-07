//
//  LoginViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let HandyDoListViewControllerSegue: String = "HandyDoListViewControllerSegue"
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Control Events
    
    @IBAction func logOn(sender: UIButton) {
        // if authenticated pass
        self .performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
        // else
        // show error message
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let handyDoListViewController = segue.destinationViewController as? HandyDoListViewController {
            // TODO pass in log in data models to handyDoListViewController
            // then navigate to the navigation controller.
            self.navigationController?.pushViewController(handyDoListViewController, animated: true)
        }
    }


}
