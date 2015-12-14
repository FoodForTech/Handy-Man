//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoListViewController: CommonViewController, UITableViewDataSource, UITableViewDelegate, HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    var handyDoList: [HandyDo]
    var handyDoToPass: HandyDo
    var indexPath: NSIndexPath
    
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
        self.indexPath = NSIndexPath()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.handyManNameLabel.text = User.sharedInstance.firstName + " " + User.sharedInstance.lastName
        self.updateTodoProgress()
        
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.indexPath = indexPath
            let handyDo: HandyDo = self.handyDoList[self.indexPath.row]
            self.handyDoBusinessService.deleteHandyDo(handyDo)
        }
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {}
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {}
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {}
    
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {
        self.handyDoList.removeAtIndex(self.indexPath.row)
        tableView.deleteRowsAtIndexPaths([self.indexPath], withRowAnimation: .Fade)
        self.updateTodoProgress()
    }
    
    // MARK: - Helper Methods
    
    func updateTodoProgress() {
        var completedHandyDos = 0
        for handyDo in self.handyDoList {
            if handyDo.status == "1" {
                completedHandyDos++
            }
        }
        self.todoProgressLabel.text = "\(completedHandyDos) of \(self.handyDoList.count)"
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoDetailViewController = navigationController.topViewController as? HandyDoDetailViewController {
                handyDoDetailViewController.handyDo = self.handyDoToPass
            }
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
}
