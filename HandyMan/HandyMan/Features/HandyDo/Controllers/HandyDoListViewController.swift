//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoListViewController : HMViewController {
    
    private struct Constants {
        static let HandyDoTodoTableViewCellId = "HandyDoTodoTableViewCellId"
        static let HandyDoListViewControllerSegue = "HandyDoListViewControllerSegue"
    }
    
    private enum RowContentType : Int {
        case New
        case InProgress
        case Completed
    }
    
    private var handyDoList: HandyDoList = HandyDoList() { didSet { self.tableView.reloadData() } }
    private var assignmentType: AssignmentType = .Assignee
    private var indexPath: NSIndexPath = NSIndexPath()
    private var handyDoTableViewCell: HandyDoTodoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var assignmentSegmentControl: UISegmentedControl!
    
    //MARK: - Init
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        self.refreshControl.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.8, alpha: 0.4)
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: #selector(HandyDoListViewController.refreshData), forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.sendSubviewToBack(self.refreshControl)
        self.assignmentSegmentControl.addTarget(self, action: #selector(HandyDoListViewController.assignmentChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handyDoList.sortHandyDoListByStatus()
        self.refreshData()
    }
    
    func configureWithHandyDoList(handyDoList: HandyDoList) {
        self.handyDoList = handyDoList
    }
    
    // MARK: - Selector Methods
    
    func refreshData() -> Void {
        self.handyDoBusinessService.retrieveHandyDoList(assignmentType) {
            (handyDoList) in
            
            switch handyDoList {
            case .Items(let handyDoList):
                self.didRetrieveHandyDoList(handyDoList)
            case .Failure(_):
                break
            default:
                break
            }
        }
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
        self.refreshData()
    }
    
    private func didRetrieveHandyDoList(handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.handyDoList.sortHandyDoListByStatus()
        self.tableView.reloadData()
        let myAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let attributedTitle = NSAttributedString(string: "Updated", attributes: myAttributes)
        self.refreshControl.attributedTitle = attributedTitle
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let handyDoDetailViewController = segue.destinationViewController as? HandyDoDetailViewController {
            handyDoDetailViewController.configure(handyDo: self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row])
        } else if let createHandyDoViewController = segue.destinationViewController as? HandyDoCreateTodoViewController {
            createHandyDoViewController.configure(handyDoList: self.handyDoList)
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    private lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()
    
}

extension HandyDoListViewController : UITableViewDataSource {
    
    // MARK: UITableView DataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.handyDoList.handyDoSectionList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case RowContentType.New.rawValue:
            return "New (\(self.handyDoList.handyDoSectionList[section].count))"
        case RowContentType.InProgress.rawValue:
            return "In Progress (\(self.handyDoList.handyDoSectionList[section].count))"
        case RowContentType.Completed.rawValue:
            return "Completed (\(self.handyDoList.handyDoSectionList[section].count))"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handyDoList.handyDoSectionList[section].count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        return handyDo.state() == "Complete"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.indexPath = indexPath
            let handyDo: HandyDo = self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row]
            self.handyDoBusinessService.deleteHandyDo(handyDo) { response in
                self.handyDoList.handyDoSectionList[indexPath.section].removeAtIndex(self.indexPath.row)
                tableView.deleteRowsAtIndexPaths([self.indexPath], withRowAnimation: .Fade)
            }
        }
    }
    
}

extension HandyDoListViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        self.performSegueWithIdentifier(Constants.HandyDoListViewControllerSegue, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
