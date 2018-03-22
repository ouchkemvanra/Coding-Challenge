//
//  MenuFirstTableViewCell.swift
//  Demo
//
//  Created by ty on on 3/21/18.
//  Copyright © 2018 vanra. All rights reserved.
//

import UIKit
import AlamofireImage

class MenuFirstTableViewCell: UITableViewCell {
    var userProfileImage: UIImageView!
    var userName: UILabel!
    var ratingStarText: UILabel!
    var ratingStarIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(red: 0/255, green: 46/255, blue: 99/255, alpha: 1)
        self.setupUserProfileImage()
        self.setupUsername()
        self.setupStarText()
        self.setupStarIcon()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Set Data for View
    func setData(){
        let userImageURL = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/18157027_1387579324639169_3978796641263566916_n.jpg?oh=59e379317e9b9f50c7dd979cb5f77b72&oe=59E6BC37"
        let circleFilter = CircleFilter()
        self.userProfileImage.af_setImage(withURL: URL.init(string: userImageURL)!, placeholderImage: UIImage.init(named: "userProfilePlaceHolder"), filter: circleFilter, runImageTransitionIfCached: true, completion: nil)
        self.userName.text = "Hello Sammer!"
        self.ratingStarText.text = "5.0"
        
       
    }
    
    
    //MARK: Setup View for UserProfile
    //MARK: Setup UserProfileImage
    func setupUserProfileImage(){
        userProfileImage = UIImageView.init(frame: CGRect(x: 8, y: 8, width: (UIScreen.main.bounds.width - 50)/4, height: (UIScreen.main.bounds.width - 50)/5))
        userProfileImage.contentMode = .scaleAspectFit
       
        self.contentView.addSubview(userProfileImage)
        self.addUserProfileImageConstraint()
        
    }
    
    //MARK: Add UserProfileImage Constraint
    func addUserProfileImageConstraint(){
        self.userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.userProfileImage.centerY(to: self.contentView)
        self.userProfileImage.leading(to: self.contentView, offset: 8, relation: .equal, isActive: true)
        self.userProfileImage.width(80)

    }
    
    
    //MARK: Setup View for User name
    //MARK: Setup Username Label
    func setupUsername(){
        self.userName = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        self.userName.font = UIFont.boldSystemFont(ofSize: 18)
        self.userName.textColor = .white
        self.userName.textAlignment = .left
        self.userName.numberOfLines = 2
        self.contentView.addSubview(userName)
        self.addUsernameConstraint()
    }
    
    //MARK: Add Username Constraint
    func addUsernameConstraint(){
        self.userName.translatesAutoresizingMaskIntoConstraints = false
        self.userName.centerY(to: self.userProfileImage)
        self.userName.leadingToTrailing(of: userProfileImage, offset: 16, relation: .equal, isActive: true)
        self.userName.width((self.contentView.bounds.size.width - 100))
        // username.leadingToTrailing(of: profileImage, offset: 20, relation: .equal, isActive: true)
        
    }
    
    
    //MARK: Setup View for Star Text Label
    //MARK: Setup Star Text
    func setupStarText(){
        self.ratingStarText = UILabel.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        self.ratingStarText.textAlignment = .left
        self.ratingStarText.textColor = .white
        self.ratingStarText.font = self.ratingStarText.font.withSize(14)
        self.ratingStarText.numberOfLines = 1
        self.contentView.addSubview(self.ratingStarText)
        self.addStarTextConstaint()
    }
    
    //MARK: Add Star Text Constraint
    func addStarTextConstaint(){
        self.ratingStarText.translatesAutoresizingMaskIntoConstraints = false
        self.ratingStarText.leading(to: self.userName)
        self.ratingStarText.topToBottom(of: self.userName, offset: -8, relation: .equal, isActive: true)
        self.ratingStarText.height(44)
       
    }
    
    //MARK: Setup View for Star Icon UIImageView
    //MARK: Setup Star Icon UIImageView
    func setupStarIcon(){
        self.ratingStarIcon = UIImageView.init(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        self.ratingStarIcon.contentMode = .scaleAspectFit
        self.ratingStarIcon.image = UIImage.init(named: "starIcon")
        self.contentView.addSubview(self.ratingStarIcon)
        self.addStarIconConstraint()
    }
    //MARK: Add Star Icon Constraint
    func addStarIconConstraint(){
        self.ratingStarIcon.translatesAutoresizingMaskIntoConstraints = false
        self.ratingStarIcon.leadingToTrailing(of: self.ratingStarText, offset: 8, relation: .equal, isActive: true)
        self.ratingStarIcon.centerY(to: self.ratingStarText)
        self.ratingStarIcon.width(12)
        self.ratingStarIcon.height(12)
        
    }
    
}
