//
//  HandyDoTodoTableViewCell.swift
//  HandyMan
//
//  Created by Don Johnson on 12/7/15.
//  Copyright © 2015 Don Johnson. All rights reserved.
//

import UIKit

class HandyDoTodoTableViewCell: UITableViewCell {
    
    private var model: HandyDo
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    init(style: UITableViewCellStyle, reuseIdentifier: String?, model:HandyDo) {
        self.model = model
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpConstraints() -> Void {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(todoDescriptionLabel)
        self.contentView.addSubview(statusLabel)
    }
    
    // MARK: Lazy Loaded Properties
    
    private lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var todoDescriptionLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}
