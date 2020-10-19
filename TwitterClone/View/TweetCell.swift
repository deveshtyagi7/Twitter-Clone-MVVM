//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 15/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
protocol TweetCellDelegate : class {
    func handleProfileImageTapped(_ cell : TweetCell)
}

class TweetCell: UICollectionViewCell {
    //MARK: - Properties
    var tweet : Tweet? {
        didSet{
            configure()
        }
    }
    
    weak var delegate : TweetCellDelegate?
    
    private lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImagetapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var captionLabel : UILabel = {
        let label = UILabel()
        label.text = "Some caption"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
        
    }()
    
    private lazy var commentBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var retweetBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "retweet"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "like"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return btn
    }()
    
    
    private let infoLabel = UILabel()
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor , left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8)
        
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor,
                     right: rightAnchor, paddingLeft: 12 ,paddingRight: 12)
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "Devesh tyagi @apple"
        
        let actionStack = UIStackView(arrangedSubviews: [commentBtn ,retweetBtn, likeBtn, shareBtn])
        actionStack.axis = .horizontal
        actionStack.spacing = 75
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        
        let underlineView =  UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             right: rightAnchor, height: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleProfileImagetapped(){
        delegate?.handleProfileImageTapped(self)
    }
    
    @objc func handleCommentTapped(){
        
    }
    
    @objc func handleLikeTapped(){
        
    }
    
    @objc func handleRetweetTapped(){
        
    }
    
    @objc func handleShareTapped(){
        
    }
    
    //MARK: - Helpers
    func configure(){
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText =  viewModel.userInfoTxt
    }
}
