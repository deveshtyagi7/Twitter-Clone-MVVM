//
//  Tweet.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 10/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Foundation

struct Tweet {
    let caption : String
    let tweetID :  String
    let uid : String
    let likes : Int
    var timestamp : Date!
    let retweetCount : Int
    
    init(tweetID : String , dict : [String : Any]){
        self.tweetID = tweetID
        self.caption = dict["caption"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.retweetCount = dict["retweets"] as? Int ?? 0
        if let timestamp = dict["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
