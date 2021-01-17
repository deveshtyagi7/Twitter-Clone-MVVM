//
//  TweetHeader.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 21/12/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

protocol TweetHeaderDelegate : class{
    func showActionSheet()
}
class TweetHeader : UICollectionReusableView{
    //MARK: - Properties
    var tweet : Tweet?{
        didSet{
            configure()
        }
    }
    
    weak var delegate : TweetHeaderDelegate?
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
        statsView.anchor(top : dateLabel.bottomAnchor, left : leftAnchor, right: rightAnchor, paddingTop: 12 , height: 40)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton,
                                                         likeButton, shareButton])
        actionStack.spacing = 72
        actionStack.distribution = .fillEqually
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(top: statsView.bottomAnchor, paddingTop : 16)
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
    private lazy var retweetsLabel = UILabel()
    private lazy var likesLabel = UILabel()
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
    
    private lazy var commentButton : UIButton = {
        let button = createButton(withImageName: "comment")
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    private lazy var retweetButton : UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    private lazy var likeButton : UIButton = {
        let button = createButton(withImageName: "like")
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    private lazy var shareButton : UIButton = {
        let button = createButton(withImageName: "share")
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Selector
    @objc func handleProfileImagetapped(){
        print("Go to User Profile")
    }
    @objc func showActionSheet(){
        delegate?.showActionSheet()
    }
    @objc func handleCommentTapped(){
        
    }
    @objc func handleRetweetTapped(){
        
    }
    @objc func handleLikeTapped(){
        
    }
    @objc func handleShareTapped(){
        
    }
    //MARK: - Helper
    
    func createButton(withImageName imageName : String) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }
    func configure(){
        guard  let tweet = tweet  else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        fullnameLabel.text = tweet.user.fullname
        usernameLabel.text = viewModel.userNameText
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimeStamp
        retweetsLabel.attributedText = viewModel.retweetAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        likeButton.tintColor = viewModel.likeButttonTintColor
    }
}
