//
//  NotificationCell.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 14/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate : class {
    func didTapProfileImage(_ cell : NotificationCell)
}
class NotificationCell : UITableViewCell{
    //MARK: - Properties
    var notification: Notification? {
        didSet{
            configure()
        }
    }
    weak var delegate : NotificationCellDelegate?
    private lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImagetapped))
        iv.addGestureRecognizer(tap)
        
        return iv
    }()
    
    let notificationLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Dome notification Text here"
        return lbl
    }()
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack  = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stack.spacing = 8
        stack.alignment = .center
        
        addSubview(stack)
        stack.centerY(inView: self,
                      leftAnchor: leftAnchor,
                      paddingLeft: 12)
        stack.anchor(right : rightAnchor, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selector
    @objc func handleProfileImagetapped(){
        delegate?.didTapProfileImage(self)
    }
    //MARK: - Helper
    func configure(){
        guard let notification = notification else { return }
        let viewModel = NotificationViewModel(notification: notification)
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        notificationLabel.attributedText = viewModel.notificationText
        
        
    }
}
