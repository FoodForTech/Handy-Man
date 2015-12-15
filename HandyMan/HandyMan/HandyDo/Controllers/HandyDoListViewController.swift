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
    
    var handyDoSectionList = [[HandyDo]]()
    
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
        self.handyDoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        self.indexPath = NSIndexPath()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.handyManNameLabel.text = User.sharedInstance.fullNameFormatted()
        self.updateTodoProgress()
        
        var newHandyDoList = [HandyDo]()
        var inProgressHandyDoList = [HandyDo]()
        var completeHandyDoList = [HandyDo]()
        for handyDo: HandyDo in self.handyDoList {
            if handyDo.status == "1" {
                newHandyDoList.append(handyDo)
            } else if handyDo.status == "2" {
                inProgressHandyDoList.append(handyDo)
            } else if handyDo.status == "3" {
                completeHandyDoList.append(handyDo)
            }
        }
        self.handyDoSectionList.append(newHandyDoList)
        self.handyDoSectionList.append(inProgressHandyDoList)
        self.handyDoSectionList.append(completeHandyDoList)
        
        tableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateTodoProgress()
        self.tableView.reloadData()
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
        return self.handyDoSectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handyDoSectionList[section].count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = handyDoSectionList[indexPath.section][indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let handyDo = self.handyDoSectionList[indexPath.section][indexPath.row]
        return handyDo.state() == "Complete"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.indexPath = indexPath
            let handyDo: HandyDo = self.handyDoSectionList[self.indexPath.section][indexPath.row]
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
            if handyDo.state() == "Complete" {
                completedHandyDos++
            }
        }
        self.todoProgressLabel.text = "\(completedHandyDos) of \(self.handyDoList.count)"
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navigationController = segue.destinationViewController as? UINavigationController {
            if let handyDoDetailViewController = navigationController.topViewController as? HandyDoDetailViewController {
                handyDoDetailViewController.handyDo = self.handyDoList[self.indexPath.row]
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
