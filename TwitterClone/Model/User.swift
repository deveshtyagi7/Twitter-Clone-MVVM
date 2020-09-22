//
//  User.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 19/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Foundation

struct User {
    let fullname : String
    let email : String
    let username : String
    var profileImageUrl : URL?
    let uid : String
    
    init(uid : String , dict : [String : AnyObject]){
        self.uid = uid
        self.fullname = dict["fullname"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        if let profileImageUrlString = dict["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}

