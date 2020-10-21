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
    
    func fetchTweets() {
        TweetServices.shared.fetchTweets { (tweets) in
            self.tweets = tweets
           
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
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: - TweetCellDelegate
extension FeedController: TweetCellDelegate{
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
