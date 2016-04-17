//
//  UIViewController_HMBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

/**
 *  HMBusinessService Extension
 */
extension UIViewController: HMBusinessServiceUIDelegate {
    
    struct Constants {
        static let kFailureTitle = "Failure"
        static let kFailureMessage = "Something when wrong while you were accessing the service."
        static let kOkTitle = "Ok"
    }
    
    // MARK: CommonBusinessService UIDelegate
    
    func willCallBlockingBusinessService(businessService: CommonBusinessService) {
        print("willCallBlockingBusinessService:")
    }
    
    func didCompleteBlockingBusinessService(businessService: CommonBusinessService) {
        print("didCompleteBlockingBusinessService:")
    }
    
    func didFailWithBusinessService(businessService: CommonBusinessService) {
        let alertController: UIAlertController = UIAlertController(title: Constants.kFailureTitle, message: Constants.kFailureMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: Constants.kOkTitle, style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    
}
