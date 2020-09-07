//
//  FeedController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
class FeedController : UIViewController{
    //MARK :- Properties
    
    
    //MARK :- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK :- Helpers
    
    func configureUI()  {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
}
