//
//  ActionSheetCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 03/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import UIKit
class ActionSheetCell : UITableViewCell {
    //MARK: - Properties
    
    var option : ActionSheetOption? {
        didSet{
            configure()
        }
    }
    private let optionImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "twitter_logo_blue")
        return iv
    }()
    
    private let titleLable : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    //MARK: - Lifecycle
    
    override init(style : UITableViewCell.CellStyle , reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(optionImageView)
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left : leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)
        
        addSubview(titleLable)
        titleLable.centerY(inView: self)
        titleLable.anchor(left : optionImageView.rightAnchor , paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    //MARK: - Helper
    func configure(){
        textLabel?.text = option?.description
    }

    
}
