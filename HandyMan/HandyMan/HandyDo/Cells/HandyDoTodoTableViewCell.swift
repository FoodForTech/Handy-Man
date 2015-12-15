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
        self.contentView.addSubview(statusView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(dateTimeLabel)
        
        let metrics: [String: NSNumber] = ["vTitleStatusSpacing": 5]
        let views: [String: UIView] = ["statusView": self.statusView,
                                       "titleLabel": self.titleLabel,
                                       "descriptionLabel": self.descriptionLabel,
                                       "dateTimeLabel": self.dateTimeLabel]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[statusView]|", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-3-[descriptionLabel]", options: NSLayoutFormatOptions.AlignAllLeading, metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-1-[statusView(==4)]-[titleLabel]->=8-[dateTimeLabel]|", options: NSLayoutFormatOptions.AlignAllFirstBaseline, metrics: metrics, views: views))
        self.dateTimeLabel.setContentCompressionResistancePriority(1000.0, forAxis: UILayoutConstraintAxis.Horizontal)
        self.dateTimeLabel.setContentHuggingPriority(1000.0, forAxis: UILayoutConstraintAxis.Horizontal)
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[descriptionLabel]-13-|", options: [], metrics: metrics, views: views))
    }
    
    // MARK: - Public Properties
    
    func configureWithModel(handyDo: HandyDo) -> Void {
        let state = handyDo.state()
        titleLabel.text = handyDo.title
        descriptionLabel.text = handyDo.todo
        dateTimeLabel.text = handyDo.formattedDate()
        if state == "New" {
            statusView.backgroundColor = UIColor.redColor()
        } else if state == "In Progress" {
            statusView.backgroundColor = UIColor.brownColor()
        } else if state == "Complete" {
            statusView.backgroundColor = UIColor.blueColor()
        } else {
            statusView.backgroundColor = UIColor.blackColor()
        }

    }
    
    // MARK: - Lazy Loaded Properties
    
    private lazy var statusView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 10)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateTimeLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 10)
        return label
    }()

}
