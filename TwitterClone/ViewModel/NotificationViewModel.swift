//
//  NotificationViewModel.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 17/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import UIKit
struct NotificationViewModel{
    private let notification : Notification
    private let type : NotificationType
    private let user : User
    
    
    var timestamp : String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second,.minute,.hour, .day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? "2m"
    }
    
    var notificationMessage : String {
        switch type{
        
        case .follow:
            return "started following you"
        case .like:
            return "liked your tweets"
        case .reply:
            return "repiled one of your tweets"
        case .retweet:
            return "retweeted one of your tweets"
        case .mention:
            return "mentioned you in a tweet"
        }
    }
    
    
    var notificationText : NSAttributedString? {
        guard let timestamp = timestamp else { return  nil}
        let attributedText = NSMutableAttributedString(string: user.username,
                                                attributes: [NSAttributedString.Key.font:
                                                                UIFont.boldSystemFont(ofSize: 12)])
        attributedText.append(NSAttributedString(string: notificationMessage,
                                                 attributes: [NSAttributedString.Key.font :
                                                                UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string: " \(timestamp)",
                                                 attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),
                                                              NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        return attributedText
    }
    
    var profileImageUrl :URL? {
        return user.profileImageUrl
    }
    init(notification : Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
}
