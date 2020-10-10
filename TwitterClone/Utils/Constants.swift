//
//  Constants.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 15/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES =  STORAGE_REF.child("profile_images")

let DB_REF =  Database.database().reference()
let REF_USERS = DB_REF.child("users")

let REF_TWEETS = DB_REF.child("tweets")
 
