//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoListViewController: CommonViewController, UITableViewDataSource, UITableViewDelegate, HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    var handyDoList: HandyDoList
    var indexPath: NSIndexPath
    var refreshControl: UIRefreshControl
    
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
        self.handyDoList = HandyDoList()
        self.handyDoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        self.indexPath = NSIndexPath()
        self.refreshControl = UIRefreshControl()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.handyManNameLabel.text = UserManager.sharedInstance.fullNameFormatted()
        self.updateTodoProgress()
        
        tableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        
        self.refreshControl.backgroundColor = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 0.4)
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "reloadData", forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.sendSubviewToBack(self.refreshControl)
    }
    
    func reloadData() -> Void {
        self.handyDoBusinessService.retrieveHandyDoList()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.handyDoList.sortHandyDoListByStatus()
        self.updateTodoProgress()
        self.tableView.reloadData()
    }
    
    // MARK: Control Events
    
    @IBAction func logout(sender: UIBarButtonItem) {
        UserManager.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITableView DataSource Methods
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "New"
        case 1:
            return "In Progress"
        case 2:
            return "Completed"
        default:
            return "Default"
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.handyDoList.handyDoSectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handyDoList.handyDoSectionList[section].count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        return handyDo.state() == "Complete"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.indexPath = indexPath
            let handyDo: HandyDo = self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row]
            self.handyDoBusinessService.deleteHandyDo(handyDo)
        }
    }
    
    // MARK: - HandyDoBusinessService NavigationDelegate
    
    func didCreateHandyDo(businessService: HandyDoBusinessService) {}
    
    func didRetrieveHandyDoList(businessService: HandyDoBusinessService, handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.handyDoList.sortHandyDoListByStatus()
        self.updateTodoProgress()
        self.tableView.reloadData()
        let myAttributes = [ NSForegroundColorAttributeName: UIColor.whiteColor() ]
        let attributedTitle = NSAttributedString(string: "Updated", attributes: myAttributes)
        self.refreshControl.attributedTitle = attributedTitle
        self.refreshControl.endRefreshing()
    }
    
    func didUpdateHandyDo(businessService: HandyDoBusinessService) {}
    
    func didDeleteHandyDo(businessService: HandyDoBusinessService) {
        self.handyDoList.handyDoSectionList[indexPath.section].removeAtIndex(self.indexPath.row)
        tableView.deleteRowsAtIndexPaths([self.indexPath], withRowAnimation: .Fade)
        self.updateTodoProgress()
    }
    
    // MARK: - Helper Methods
    
    func updateTodoProgress() {
        var completedHandyDos = 0
        var totalHandyDos = 0
        for handyDoArray in self.handyDoList.handyDoSectionList {
            for handyDo in handyDoArray {
                if handyDo.state() == "Complete" {
                    completedHandyDos++
                }
                totalHandyDos++
            }
        }
        self.todoProgressLabel.text = "\(completedHandyDos) of \(totalHandyDos)"
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoDetailViewController = navigationController.topViewController as? HandyDoDetailViewController {
                handyDoDetailViewController.handyDo = self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row]
            }
        } else if let createHandyDoViewController = segue.destinationViewController as? HandyDoCreateTodoViewController {
            createHandyDoViewController.handyDoList = self.handyDoList
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(navigationDelegate: self, uiDelegate: self)
        return businessService
    }()
}
