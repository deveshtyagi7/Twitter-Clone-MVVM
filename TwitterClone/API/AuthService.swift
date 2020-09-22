//
//  AuthService.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 15/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//
import UIKit
import Firebase

struct AuthCredentials {
    let email : String
    let password : String
    let fullname : String
    let username :  String
    let profileImage : UIImage
}

struct AuthService {
    static let shared =  AuthService()
    
    func logUserIn(withEmail email : String , password : String,completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(with credentials : AuthCredentials , completion : @escaping(Error? ,DatabaseReference) -> Void){
        print("auth callled")
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, err) in
                    if let err = err{
                        print("DEBUG : Error is \(err.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    let values = ["email" : credentials.email,
                                  "username" : credentials.username,
                                  "fullname" : credentials.fullname,
                                  "profileImageUrl" : profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values ,withCompletionBlock: completion)
                     
                    
                }
            }
        }
    }
    
 
    
}
