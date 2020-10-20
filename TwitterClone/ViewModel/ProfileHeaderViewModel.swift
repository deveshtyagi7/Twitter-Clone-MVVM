//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 20/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Foundation
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
