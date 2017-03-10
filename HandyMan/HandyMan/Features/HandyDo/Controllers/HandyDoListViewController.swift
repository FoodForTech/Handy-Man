//
//  HandyDoListViewController.swift
//  HandyMan
//
//  Created by Don Johnson on 12/6/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class HandyDoListViewController : HMViewController {
    
    fileprivate struct Constants {
        static let HandyDoTodoTableViewCellId = "HandyDoTodoTableViewCellId"
        static let HandyDoListViewControllerSegue = "HandyDoListViewControllerSegue"
    }
    
    fileprivate enum RowContentType : Int {
        case new
        case inProgress
        case completed
    }
    
    fileprivate var handyDoList: HandyDoList = HandyDoList() { didSet { self.tableView.reloadData() } }
    fileprivate var assignmentType: AssignmentType = .assignee
    fileprivate var indexPath: IndexPath = IndexPath()
    fileprivate var handyDoTableViewCell: HandyDoTodoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
    fileprivate var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var assignmentSegmentControl: UISegmentedControl!
    
    //MARK: - Init
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        self.tableView.register(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        self.refreshControl.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.8, alpha: 0.4)
        self.refreshControl.tintColor = UIColor.white
        self.refreshControl.addTarget(self, action: #selector(HandyDoListViewController.refreshData), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.sendSubview(toBack: self.refreshControl)
        self.assignmentSegmentControl.addTarget(self, action: #selector(HandyDoListViewController.assignmentChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handyDoList.sortHandyDoListByStatus()
        self.refreshData()
    }
    
    func configureWithHandyDoList(_ handyDoList: HandyDoList) {
        self.handyDoList = handyDoList
    }
    
    // MARK: - Selector Methods
    
    func refreshData() -> Void {
        self.handyDoBusinessService.retrieveHandyDoList(assignmentType) {
            (handyDoList) in
            
            switch handyDoList {
            case .items(let handyDoList):
                self.didRetrieveHandyDoList(handyDoList)
            case .failure(_):
                break
            default:
                break
            }
        }
    }
    
    func assignmentChanged(_ sender: UISegmentedControl) -> Void {
        switch sender.selectedSegmentIndex {
        case 0:
            self.assignmentType = .assignee
        case 1:
            self.assignmentType = .assignTo
        default:
            break;
        }
        self.refreshData()
    }
    
    fileprivate func didRetrieveHandyDoList(_ handyDoList: [HandyDo]) {
        self.handyDoList.handyDoList = handyDoList
        self.handyDoList.sortHandyDoListByStatus()
        self.tableView.reloadData()
        let myAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let attributedTitle = NSAttributedString(string: "Updated", attributes: myAttributes)
        self.refreshControl.attributedTitle = attributedTitle
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let handyDoDetailViewController = segue.destination as? HandyDoDetailViewController {
            handyDoDetailViewController.configure(handyDo: self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row])
        } else if let createHandyDoViewController = segue.destination as? HandyDoCreateTodoViewController {
            createHandyDoViewController.configure(handyDoList: self.handyDoList)
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    fileprivate lazy var handyDoBusinessService: HandyDoBusinessService = {
        let businessService = HandyDoBusinessService(uiDelegate: self)
        return businessService
    }()
    
}

extension HandyDoListViewController : UITableViewDataSource {
    
    // MARK: UITableView DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.handyDoList.handyDoSectionList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case RowContentType.new.rawValue:
            return "New (\(self.handyDoList.handyDoSectionList[section].count))"
        case RowContentType.inProgress.rawValue:
            return "In Progress (\(self.handyDoList.handyDoSectionList[section].count))"
        case RowContentType.completed.rawValue:
            return "Completed (\(self.handyDoList.handyDoSectionList[section].count))"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handyDoList.handyDoSectionList[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let handyDo = self.handyDoList.handyDoSectionList[indexPath.section][indexPath.row]
        return handyDo.state() == "Complete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.indexPath = indexPath
            let handyDo: HandyDo = self.handyDoList.handyDoSectionList[self.indexPath.section][indexPath.row]
            self.handyDoBusinessService.deleteHandyDo(handyDo) { response in
                self.handyDoList.handyDoSectionList[indexPath.section].remove(at: self.indexPath.row)
                tableView.deleteRows(at: [self.indexPath], with: .fade)
            }
        }
    }
    
}

extension HandyDoListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        self.performSegue(withIdentifier: Constants.HandyDoListViewControllerSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
