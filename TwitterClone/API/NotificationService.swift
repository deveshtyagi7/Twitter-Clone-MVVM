//
//  NotificationService.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import Firebase
struct NotificationService {
    static let shared = NotificationService()
    
    func uploadNotification(type : NotificationType ,
                            tweet : Tweet? = nil,
                            user : User? = nil){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var values :[String : Any] = ["timestamp" : Int(Date().timeIntervalSince1970),
                                      "uid" : uid,
                                      "type" : type.rawValue]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
            REF_NOTIFICATIONS.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        }else if let user = user {
            REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
        }
    }
    
    func fetchNotification(_ completion : @escaping([Notification]) -> Void){
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? [String : AnyObject] else { return }
            
            guard let uid = dict["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let notification = Notification(user: user, dict: dict)
                notifications.append(notification)
                completion(notifications)
            }
        }
        
    }
}
