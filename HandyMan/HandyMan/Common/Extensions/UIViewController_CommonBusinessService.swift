//
//  UIViewController_CommonBusinessService.swift
//  HandyMan
//
//  Created by Don Johnson on 12/9/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

/**
 *  CommonBusinessService Extension
 */
extension UIViewController: CommonBusinessServiceUIDelegate {
    
    // MARK: CommonBusinessService UIDelegate
    
    func willCallBlockingBusinessService(businessService: CommonBusinessService) {
        print("willCallBlockingBusinessService:")
    }
    
    func didCompleteBlockingBusinessService(businessService: CommonBusinessService) {
        print("didCompleteBlockingBusinessService:")
    }
    
    func didFailWithBusinessService(businessService: CommonBusinessService) {
        print("didFailWithBusinessService:)")
        
        let alertController: UIAlertController = UIAlertController(title: "Failure", message: "Something went wrong while you were accessing the service.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction) -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
        
    }
    
}
