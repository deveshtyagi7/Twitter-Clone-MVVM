//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 30/12/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}
struct UploadTweetViewModel {
    let actionButtonTitle : String
    let placeholderText : String
    var shouldShowReplyLabel : Bool
    var replyText : String?
    init(config :  UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's Happening"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
