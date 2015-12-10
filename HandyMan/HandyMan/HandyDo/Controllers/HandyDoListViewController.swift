//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var handyDoList: [HandyDo]
    var handyDoToPass: HandyDo
    
    private var handyDoTableViewCell: HandyDoTodoTableViewCell
    
    @IBOutlet weak var handyManImageView: UIImageView!
    @IBOutlet weak var handyManNameLabel: UILabel!
    @IBOutlet weak var todoProgressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    struct Constants {
        static let HandyDoTodoTableViewCellId = "HandyDoTodoTableViewCellId"
        static let HandyDoListViewControllerSegue = "HandyDoListViewControllerSegue"
    }
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        self.handyDoList = []
        self.handyDoToPass = HandyDo()
        self.handyDoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.handyManNameLabel.text = User.sharedInstance.firstName + " " + User.sharedInstance.lastName
        self.todoProgressLabel.text = "3 of \(self.handyDoList.count)"
        
        tableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
    }
    
    // MARK: UITableView DataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handyDoList.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = handyDoList[indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.handyDoToPass = handyDoList[indexPath.row]
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoDetailViewController = navigationController.topViewController as? HandyDoDetailViewController {
                handyDoDetailViewController.handyDo = self.handyDoToPass
            }
        }
    }
}
