//
//  Notification.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import Foundation
enum NotificationType : Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}
struct Notification {
    let tweetID  : String?
    var timestamp : Date!
    let user :User
    var tweet : Tweet?
    var type: NotificationType!
    init(user : User, dict : [String : AnyObject]) {
        self.user = user
        
        self.tweetID = dict["tweetID"] as? String ?? ""
        if let timestamp = dict["timestamp"] as? Double{
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        if let type = dict["type"] as? Int{
            self.type = NotificationType(rawValue: type)
        }
    }
    
}
