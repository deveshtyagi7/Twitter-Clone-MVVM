//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 19/10/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

class ProfileFilterCell : UICollectionViewCell {
    //MARK: - Properties
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test filter"
        return label
    }()
    
    override var isSelected: Bool{
        didSet{
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
