//
//  TweetServices.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 10/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//


import Firebase

struct TweerServices {
    static let shared = TweerServices()
    
    func uploadTweet(caption : String, completion : @escaping(Error?, DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid" : uid,
                      "timestamp" : Int(NSDate().timeIntervalSince1970),
                      "likes" : 0,
                      "retweets": 0,
                      "caption" : caption] as [String : Any]
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void){
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? [String : Any] else { return }
            guard let uid = dict["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetID: tweetID, dict: dict)
                tweets.append(tweet)
                completion(tweets)
            }
            
            
        }
    }
}

