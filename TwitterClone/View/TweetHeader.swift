//
//  TweetHeader.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 21/12/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
class TweetHeader : UICollectionReusableView{
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel , usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top : captionLabel.bottomAnchor, left: leftAnchor,paddingTop: 20, paddingLeft: 16)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top : dateLabel.bottomAnchor, left : leftAnchor, right: rightAnchor, paddingTop: 20 , height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    
    private lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImagetapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let usernameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "@deveshtyagi7"
        return lbl
    }()
    
    private let fullnameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.text = "Devesh Tyagi"
        return lbl
    }()
    
    private lazy var captionLabel : UILabel = {
        let label = UILabel()
        label.text = "Some caption"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.text = "6:33PM-1/20/2020"
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var optionButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .lightGray
        btn.setImage(#imageLiteral(resourceName: "down_arrow_24pt"), for: .normal)
        btn.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return btn
    }()
    private lazy var retweetsLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Retweets"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    private lazy var likesLabel : UILabel = {
        let label = UILabel()
        label.text = "0 Likes"
        label.font = UIFont.systemFont(ofSize:14)
        label.numberOfLines = 0
        return label
    }()
    private lazy var statsView :UIView = {
       let v = UIView()
      //  v.backgroundColor = .white
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        
        v.addSubview(divider1)
        divider1.anchor(top : v.topAnchor , left: v.leftAnchor, right: v.rightAnchor, paddingLeft: 8, height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.spacing = 12
        stack.axis = .horizontal
        
        v.addSubview(stack)
        stack.centerY(inView: v)
        stack.anchor(left:v.leftAnchor, paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        
        v.addSubview(divider2)
        divider2.anchor(  left: v.leftAnchor, bottom: v.bottomAnchor, right: v.rightAnchor, paddingLeft: 8, height: 1.0)
        return v
    }()
    //MARK: - Selector
    @objc func handleProfileImagetapped(){
        print("Go to User Profile")
    }
    @objc func showActionSheet(){
        print("Show action sheet")
    }
    
}
