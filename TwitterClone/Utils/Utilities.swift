//
//  Utilities.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 08/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
class Utilities {
    func inputContainerView(withImage image: UIImage , textField : UITextField) -> UIView{
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor , bottom: view.bottomAnchor,paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,                       paddingLeft: 8, paddingBottom: 8)
        
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .white
        line.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 0.75)
       
        
        
        return view
    }
    
    func textFieldWithPlaceholder(withPlaceholder placeholder : String)-> UITextField{
        let tf = UITextField()
       
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton{
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes:                                        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),                                    NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes:                                      [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),                                NSAttributedString.Key.foregroundColor : UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
}
