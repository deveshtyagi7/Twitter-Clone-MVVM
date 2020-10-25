//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 18/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
protocol ProfileHeaderDelegate : class {
    func handleDismiss()
    func handleEditprofileFollow(_ header : ProfileHeader)
}
class ProfileHeader : UICollectionReusableView {
    //MARK: - Properties
    
    var user :User? {
        didSet{
            configure()
        }
    }
    
    weak var delegate : ProfileHeaderDelegate?
    private let filterBar = ProfileFilterView()
    
    private lazy var containerView : UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(backBtn)
        backBtn.anchor(top : view.topAnchor, left: view.leftAnchor,
                       paddingTop: 42, paddingLeft: 16)
        backBtn.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var backBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    private let profileImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    
     lazy var editProfileFollowButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Loading", for: .normal)
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.layer.borderWidth = 1.25
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return btn
        
    }()
    private let usernameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    private let fullnameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private let bioLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 3
        lbl.text = "This is a user bio that will span more than one line fer test purposes"
        return lbl
    }()
    
    private let underlineView : UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private let followingLabel : UILabel = {
       let lbl = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(followTap)
        return lbl
    }()
    
    private let followerLabel : UILabel = {
       let lbl = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(followTap)
        return lbl
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.anchor(top : topAnchor, left: leftAnchor ,right: rightAnchor , height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top : containerView.bottomAnchor,
                                left: leftAnchor,
                                paddingTop: -24,
                                paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor,
                                       right: rightAnchor,
                                       paddingTop: 12,
                                       paddingRight: 12)
        editProfileFollowButton.setDimensions(width: 100 , height: 36)
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                     right: rightAnchor , paddingTop: 8,
                     paddingLeft: 12, paddingRight: 12)
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followerLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        followStack.anchor(top: stack.bottomAnchor , left: leftAnchor,
                           paddingTop: 8, paddingLeft: 12)
        
        addSubview(filterBar)
        filterBar.delegate = self
        filterBar.anchor(left : leftAnchor , bottom: bottomAnchor ,right: rightAnchor , height: 50)
        
        addSubview(underlineView)
        underlineView.anchor(left :leftAnchor, bottom: bottomAnchor , width: frame.width / 3 ,height: 2)
                                       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleDismiss(){
        delegate?.handleDismiss()
    }
    
    @objc func handleEditProfileFollow(){
        delegate?.handleEditprofileFollow(self)
    }
    
    @objc func handleFollowersTapped(){
        
    }
    @objc func handleFollowingTapped(){
        
    }
    
    //MARK: - Helpers
    func configure(){
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followerLabel.attributedText = viewModel.followersString
        followingLabel.attributedText = viewModel.followingString
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
}

extension ProfileHeader : ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indepath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indepath) as? ProfileFilterCell else {
            return
        }
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
    
    
}
