//
//  MenuListTableViewCell.swift
//  Demo
//
//  Created by ty on on 3/21/18.
//  Copyright © 2018 vanra. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    var menuListIcon: UIImageView!
    var menuListTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupMenuListIcon()
        self.setupMenuListLabael()
    }
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    //MARK: Set Data
    func setData(title: String, icon: UIImage){
        self.menuListTitle.text = title
        self.menuListIcon.image = icon
    }
    
    
    //MARK: Setup View
    //MARK: Setup View for MenuList Icon
    //MARK: Setup MenuList Icon
    func setupMenuListIcon(){
        self.menuListIcon = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        self.menuListIcon.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.menuListIcon)
        self.addMenuListIconConstraint()
    }
    
    //MARK: Add MenuList Constraint
    func addMenuListIconConstraint(){
        self.menuListIcon.translatesAutoresizingMaskIntoConstraints = false
        self.menuListIcon.leading(to: self.contentView, offset: 20, relation: .equal, isActive: true)
        self.menuListIcon.centerY(to: self.contentView)
        self.menuListIcon.width(25)
        self.menuListIcon.height(25)
    }
    
    
    //MARK: Setup View for MenuList Title Label
    //MARK: Setup MenuList Title Label
    func setupMenuListLabael(){
        self.menuListTitle = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        self.menuListTitle.textColor = .black
        self.menuListTitle.textAlignment = .left
        self.menuListTitle.text = ""
        
        self.contentView.addSubview(self.menuListTitle)
        self.addMenuListTitleConstraint()
    }
    
    //MARK: Add MenuList Title Constraint
    func addMenuListTitleConstraint(){
        self.menuListTitle.translatesAutoresizingMaskIntoConstraints = false
        self.menuListTitle.leadingToTrailing(of: self.menuListIcon, offset: 20, relation: .equal, isActive: true)
        self.menuListTitle.centerY(to: self.contentView)
        self.menuListTitle.height(44)
        
    }
    
}
