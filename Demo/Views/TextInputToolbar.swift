//
//  TextInputToolbar.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class TextInputToolbar: UIToolbar {

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Hello World"
        textField.contentVerticalAlignment = .center
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = Helper.pixelOne
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
        
        return textField
    }()
    
    lazy var button: UIButton = {

        let button = UIButton(type: .custom)
        button.setTitle("发送", for: .normal)
        button.setTitleColor(UIColor.ColorSet.weChat, for: .normal)
        return button
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(textField)
        addSubview(button)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["textField" : textField, "button" : button] as [String : Any]

        let constraints = [
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[textField]-[button]-|",
                options: [.alignAllCenterY],
                metrics: nil,
                views: viewsDictionary
            )
        ]
        NSLayoutConstraint.activate(constraints.flatMap{ $0 })
        
//        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        
        NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 6).isActive = true
        NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -6).isActive = true

    }

}
