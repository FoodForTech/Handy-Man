//
//  HandyDoTodoTableViewCell.swift
//  HandyMan
//
//  Created by Don Johnson on 12/7/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

final class HandyDoTodoTableViewCell : UITableViewCell {
    
    class func viewHeight() -> CGFloat {
        return 80
    }
    
    fileprivate var model: HandyDo
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.model = HandyDo()
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setUpConstraints()
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
    
    /** This cell has been programmically created with no associated xib file.  */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpConstraints() {
        self.contentView.addSubview(statusView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(dateTimeLabel)
        
        let metrics: [String: NSNumber] = ["vTitleStatusSpacing": 5]
        let views: [String: UIView] = ["statusView": self.statusView,
                                       "titleLabel": self.titleLabel,
                                       "descriptionLabel": self.descriptionLabel,
                                       "dateTimeLabel": self.dateTimeLabel]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[statusView]|", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-1-[statusView(==6)]", options: [], metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-3-[descriptionLabel]", options: NSLayoutFormatOptions.alignAllLeading, metrics: metrics, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]->=8-[dateTimeLabel]|", options: NSLayoutFormatOptions.alignAllFirstBaseline, metrics: metrics, views: views))
        self.dateTimeLabel.setContentCompressionResistancePriority(1000.0, for: UILayoutConstraintAxis.horizontal)
        self.dateTimeLabel.setContentHuggingPriority(1000.0, for: UILayoutConstraintAxis.horizontal)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[descriptionLabel]-13-|", options: [], metrics: metrics, views: views))
    }
    
    func configureWithModel(_ handyDo: HandyDo) {
        titleLabel.text = handyDo.title
        descriptionLabel.text = handyDo.todo
        dateTimeLabel.text = handyDo.formattedDate()
        switch handyDo.state() {
        case "New":
            statusView.backgroundColor = UIColor.yellow
        case "In Progress":
            statusView.backgroundColor = UIColor.orange
        case "Complete":
            statusView.backgroundColor = UIColor.green
        default:
            statusView.backgroundColor = UIColor.black
        }
    }
    
    // MARK: - Lazy Loaded Properties
    
    fileprivate lazy var statusView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir Next-Medium", size: 17)
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir Next", size: 10)
        label.numberOfLines = 2
        return label
    }()
    
    fileprivate lazy var dateTimeLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 12)
        return label
    }()
    
}
