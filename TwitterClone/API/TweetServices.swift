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
}

