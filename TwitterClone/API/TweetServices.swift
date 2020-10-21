//
//  TweetServices.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 10/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//


import Firebase

struct TweetServices {
    static let shared = TweetServices()
    
    func uploadTweet(caption : String, completion : @escaping(Error?, DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid" : uid,
                      "timestamp" : Int(NSDate().timeIntervalSince1970),
                      "likes" : 0,
                      "retweets": 0,
                      "caption" : caption] as [String : Any]
        let tweetId = REF_TWEETS.childByAutoId()
        tweetId.updateChildValues(values) { (err, ref) in
            guard let tweetId = tweetId.key else { return }
            REF_USER_TWEETS.child(uid).updateChildValues([tweetId : 1], withCompletionBlock: completion)
        }
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
    
    func fetchTweet(forUser user : User , completion :@escaping([Tweet]) -> Void){
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { (snapshot) in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { (snapshot) in
                guard let dict = snapshot.value as? [String : Any] else { return }
                guard let uid = dict["uid"] as? String else { return }
                
                UserService.shared.fetchUser(uid: uid) { (user) in
                    let tweet = Tweet(user: user, tweetID: tweetID, dict: dict)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
    
    
}

