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
    
    private var handyDoTableViewCell: HandyDoTodoTableViewCell
    
    @IBOutlet weak var handyManImageView: UIImageView!
    @IBOutlet weak var handyManNameLabel: UILabel!
    @IBOutlet weak var todoProgressLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!

    struct Constants {
        static let HandyDoTodoTableViewCellId = "HandyDoTodoTableViewCellId"
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.handyDoList = []
        self.handyDoTableViewCell = HandyDoTodoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.HandyDoTodoTableViewCellId)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoTableView.dataSource = self
        self.todoTableView.delegate = self

        todoTableView.registerClass(HandyDoTodoTableViewCell.self, forCellReuseIdentifier: Constants.HandyDoTodoTableViewCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handyDoList.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HandyDoTodoTableViewCell.viewHeight()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HandyDoTodoTableViewCell = self.todoTableView.dequeueReusableCellWithIdentifier(Constants.HandyDoTodoTableViewCellId) as! HandyDoTodoTableViewCell
        let handyDo = handyDoList[indexPath.row]
        cell.configureWithModel(handyDo)
        return cell
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
