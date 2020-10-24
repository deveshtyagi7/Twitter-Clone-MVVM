//
//  UserService.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 19/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    func fetchUser(uid : String, completion : @escaping(User) -> Void){
  
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dict = snapshot.value as? [String : AnyObject] else { return }
            
            let user = User(uid: uid, dict: dict)
            print("FEtched USer")
            completion(user)
        }
    }
    
    func fetchUsers(completion : @escaping([User]) -> Void){
        var users = [User]()
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dict = snapshot.value as? [String : AnyObject] else { return }
            let user = User(uid: uid, dict: dict)
            users.append(user)
            completion(users)
        }
    }
}
