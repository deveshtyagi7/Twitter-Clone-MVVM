//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 17/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
struct TweetViewModel {
    let tweet : Tweet
    let user : User
    var profileImageUrl :URL? {
        return tweet.user.profileImageUrl 
    }
    var timestamp : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second,.minute,.hour, .day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var headerTimeStamp :String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a • MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    var userNameText : String {
        return "@\(user.username)"
    }
    
    var retweetAttributedString : NSAttributedString? {
        return attributedText(withValue: tweet.retweetCount, text: "Retweets")
        
    }
    
    var likesAttributedString : NSAttributedString? {
        return attributedText(withValue: tweet.likes, text: "Likes")
    }
    
    var userInfoTxt : NSAttributedString{
        let title = NSMutableAttributedString(string: user.fullname,
                                       attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username.lowercased())",
                                        attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor : UIColor.lightGray]))
        title.append(NSAttributedString(string: " • \(timestamp)",
                                        attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor : UIColor.lightGray]))
        print("DEBUG : Time= \(timestamp)")
        return title
    }
    
    func attributedText(withValue value :Int, text :String) -> NSAttributedString{
        let attributedTitle = NSMutableAttributedString(string: "\(value)" ,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: "\(text)" ,
                                                  attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                              .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
    init(tweet : Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
