//
//  HandyDoTodoTableViewCell.swift
//  HandyMan
//
//  Created by Don Johnson on 12/7/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoTodoTableViewCell: UITableViewCell {
    struct Constants {
        static let kViewHeight: CGFloat = 80.0
    }
    
    class func viewHeight() -> CGFloat {
        return Constants.kViewHeight
    }
    
    private var model: HandyDo
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.model = HandyDo()
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setUpConstraints()
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() -> Void {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(statusLabel)
        
        let metrics: [String: NSNumber] = ["vTitleStatusSpacing": 5]
        let views: [String: UIView] = ["titleLabel": self.titleLabel,
                                          "statusLabel": self.statusLabel]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel][statusLabel]-|", options: NSLayoutFormatOptions.AlignAllLeading , metrics: metrics, views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]", options: [], metrics: metrics, views: views))
        
    }
    
    // MARK: - Public Properties
    
    func configureWithModel(handyDo: HandyDo) -> Void {
        titleLabel.text = handyDo.title
        statusLabel.text = handyDo.status
        if (handyDo.status == "complete") {
           
        } else {
           
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    private lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        return label
    }()
    
    private lazy var statusLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}
