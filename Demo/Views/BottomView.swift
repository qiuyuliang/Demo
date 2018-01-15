//
//  BottomView.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomView: UIView {

    lazy var button: UIButton = {
        let button = UIButton.gradientButton(fromColors: [UIColor.randomColor, UIColor.randomColor], buttonSize: CGSize(width: 120, height: 40), buttonTitle: "UIView")
        return button
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            button.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12).isActive = true
        } else {
            button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        }
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
