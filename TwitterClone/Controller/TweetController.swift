//
//  TweetController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 18/12/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "TweetHeader"
class TweetController : UICollectionViewController{
    //MARK: - Properties
    private let tweet : Tweet
    
    private var replies = [Tweet]() {
        didSet{ collectionView.reloadData()}
    }
    //MARK: - LifeCycle
    
    init(tweet : Tweet){
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchReplies()
    }
    //MARK: - Apis
    func fetchReplies(){
        TweetServices.shared.fetxhReplies(forTweet: tweet) { (replies) in
            self.replies = replies
        }
    }
    //MARK: - Helpers
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    
    //MARK: - Properties

    
}
    //MARK: - UICollectionViewDataSource
extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = replies[indexPath.row]
        return cell
    }
}
    //MARK: - UICollectionViewDelegate


extension TweetController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
        header.tweet = tweet
        return header
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension TweetController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.height).height
        return CGSize(width: view.frame.width, height: captionHeight + 260)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
