//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 15/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
