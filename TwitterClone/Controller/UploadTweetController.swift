//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 22/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user : User
    private var config : UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    private lazy var actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
   private let profileImageView : UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        
        return iv
    }()
    private lazy var replyLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "replying to @deveshtyagi7"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
       return lbl
    }()
    private let captionTextView = CaptionTextView()
    
    
    //MARK: - Lifecycle
    
    init(user : User , config : UploadTweetConfiguration){
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet(){
        guard let caption = captionTextView.text else { return }
        TweetServices.shared.uploadTweet(caption: caption, type: config) { (error, ref) in
            if error != nil{
                print("Error while uploadind tweet ==> \(error!.localizedDescription)")
            } else {
                if case .reply(let tweet) = self.config {
                    NotificationService.shared.uploadNotification(type: .reply, tweet: tweet)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
   //     stack.alignment = .leading
        stack.spacing = 12
        
        
        view.addSubview(stack)
        stack.anchor(top : view.safeAreaLayoutGuide.topAnchor,
                     left : view.leftAnchor ,right: view.rightAnchor,
                     paddingTop: 16 ,paddingLeft: 16 ,
                     paddingRight: 16)
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    func configureUIComponents(){
        
    }
    fileprivate func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
