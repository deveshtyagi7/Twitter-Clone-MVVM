//
//  UserCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 24/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

class UserCell :UITableViewCell {
    
    //MARK: - Properties
     var user: User?{
        didSet{
            configure()
        }
    }
    
    private lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.backgroundColor = .twitterBlue
       
        return iv
    }()
    private let usernameLbl : UILabel = {
        let label = UILabel()
        label.text = "USername"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
        
    }()
    private let fullNameLbl : UILabel = {
        let label = UILabel()
        label.text = "full Name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
        
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLbl , fullNameLbl])
        stack.axis = .vertical
        stack.spacing = 2
        
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,
                      paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        usernameLbl.text = user.username
        fullNameLbl.text = user.fullname
        
    }
}
