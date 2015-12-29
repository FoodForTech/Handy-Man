//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoListViewController: CommonViewController, UITableViewDataSource, UITableViewDelegate, HandyDoBusinessServiceNavigationDelegate, HandyDoBusinessServiceUIDelegate {
    
    private var handyDoList: HandyDoList
    private var assignmentType: AssignmentType
    private var indexPath: NSIndexPath
    private var refreshControl: UIRefreshControl
    private var handyDoTableViewCell: HandyDoTodoTableViewCell

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var assignmentSegmentControl: UISegmentedControl!
    
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
        self.assignmentType = .Assignee
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        self.refreshControl.backgroundColor = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 0.4)
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "reloadData", forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.sendSubviewToBack(self.refreshControl)
        self.assignmentSegmentControl.addTarget(self, action: "assignmentChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.orangeColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.handyDoList.sortHandyDoListByStatus()
        self.tableView.reloadData()
    }
    
    func configureWithHandyDoList(handyDoList: HandyDoList) {
        self.handyDoList = handyDoList
    }
    
    // MARK: UITableView DataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.handyDoList.handyDoSectionList.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "New (\(self.handyDoList.handyDoSectionList[section].count))"
        case 1:
            return "In Progress (\(self.handyDoList.handyDoSectionList[section].count))"
        case 2:
            return "Completed (\(self.handyDoList.handyDoSectionList[section].count))"
        default:
            return "Default"
        }
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
    }
    
    // MARK: - Helper Methods
    
    func reloadData() -> Void {
        self.handyDoBusinessService.retrieveHandyDoList(assignmentType)
    }
    
    func assignmentChanged(sender: UISegmentedControl) -> Void {
        switch sender.selectedSegmentIndex {
        case 0:
            self.assignmentType = .Assignee
        case 1:
            self.assignmentType = .AssignTo
        default:
            break;
        }
        self.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let handyDoDetailViewController = segue.destinationViewController as? HandyDoDetailViewController {
            handyDoDetailViewController.handyDo = self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row]
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
