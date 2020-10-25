//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 20/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//
import UIKit

enum ProfileFilterOptions :Int, CaseIterable{
    case tweets
    case replies
    case likes
    
    var description : String {
        switch self {
        case .tweets : return "Tweets"
        case .replies : return "Tweets & replies"
        case . likes : return "Likes"
       
        }
    }
}
struct ProfileHeaderViewModel {
    private let user : User
    
    let usernameText : String
    var followersString : NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: " followers")
    }
    var followingString : NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: " following")
    }
    
    var actionButtonTitle : String{
        //if user is current user then set to edit profile
        // else figure out following/ not following
        if user.isCurrentUser{
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser{
            return "Follow"
        }
        if user.isFollowed{
            return "Following"
        }
        return "Loading"
    }
    init(user : User){
        self.user = user
        self.usernameText = "@\(user.username)"
    }
    
    func attributedText(withValue value :Int, text :String) -> NSAttributedString{
        let attributedTitle = NSMutableAttributedString(string: "\(value)" ,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: "\(text)" ,
                                                  attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                              .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
