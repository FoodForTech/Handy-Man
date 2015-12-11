//
//  HandyDoDetailViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/8/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoDetailViewController: CommonViewController {
    
    var handyDo: HandyDo = HandyDo()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = handyDo.title
        todoLabel.text = handyDo.todo
        statusLabel.text = handyDo.status
    }

    @IBAction func done(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
