//
//  LoginFooterView.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/9.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class LoginFooterView: UIView {

    lazy var loginButton: UIButton = {
        let button = UIButton.pureColorButton(title: "登录", backgroundColor: UIColor.ColorSet.weChat)
        return button
    }()
    
    
    // MARK: - LifeCycle
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            addSubview(loginButton)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        if #available(iOS 11.0, *) {
            loginButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
            loginButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        } else {
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 100)
    }
    
}
