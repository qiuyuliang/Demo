//
//  BottomToolbar.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomToolbar: UIToolbar {
    
    lazy var button: UIButton = {
        let button = UIButton.gradientButton(fromColors: [UIColor.randomColor, UIColor.randomColor], buttonSize: CGSize(width: 120, height: 40), buttonTitle: "UIToolbar")
        return button
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(button)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize.init(width: size.width, height: 60)
    }

}
