//
//  BottomTabBar.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/15.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomTabBar: UIToolbar {

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(stackView)
        
        for _ in 1...5 {
            let bottomTabBarItemView = BottomTabBarItemView()
            stackView.addArrangedSubview(bottomTabBarItemView)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }

}
