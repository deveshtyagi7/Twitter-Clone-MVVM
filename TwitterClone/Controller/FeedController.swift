//
//  FeedController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth

private let reuseIdentifier = "TweetCell"


class FeedController : UICollectionViewController{
    //MARK: - Properties
    var user : User? {
        didSet{
        print(user?.profileImageUrl)
           configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet](){
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - API
    
    fileprivate func checkIfUserLikedTweets(_ tweets: [Tweet]) {
        for(index ,tweet) in tweets.enumerated(){
            TweetServices.shared.checkIfUserLikedTweet(tweet) { (didLike) in
                guard didLike == true else { return }
                self.tweets[index].didLike = true
            }
        }
    }
    
    func fetchTweets() {
        TweetServices.shared.fetchTweets { (tweets) in
            self.tweets = tweets
            self.checkIfUserLikedTweets(tweets)
           
        }
    }
    
    
    //MARK: - Helpers
    
    fileprivate func configureLeftBarButton() {
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    fileprivate func configureRightBarButton() {
       // guard let user = user else { return }
        
        let logoutBtn = UIBarButtonItem()
        logoutBtn.title = "Logout"
        logoutBtn.target = self
        logoutBtn.action = #selector(logUserOut)
        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    func configureUI()  {
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        configureRightBarButton()
    }
    
   @objc func logUserOut()  {
        do{
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch let error {
            print("Error while loging out \(error.localizedDescription)")
        }
       
    }
}
//MARK: - UICollectionViewDelegate/DataSource
extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TweetController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size( forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 72)
    }
}

//MARK: - TweetCellDelegate
extension FeedController: TweetCellDelegate{
    func handleLikeTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        TweetServices.shared.likeTweet(tweet: tweet) { (err, ref) in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
            cell.tweet?.likes = likes
            
            //This will ensure only upload notification for if tweet is being like
            guard !tweet.didLike  else { return }
            NotificationService.shared.uploadNotification(type: .like, tweet: tweet)
        }
    }
    func handleReplyTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))
        let nav  = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
