//
//  BottomTabBarController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/15.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomTabBarController: BaseViewController {

    lazy var tabBarView: BottomTabBar = {
        let tabBarView = BottomTabBar()
        return tabBarView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tabBarView)
    }
    
    override func viewDidLayoutSubviews() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            tabBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            //底部贴紧安全区域底部
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            //右侧紧贴父视图右侧
            tabBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            //高度为49
            tabBarView.heightAnchor.constraint(equalToConstant: 49).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint(item: tabBarView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: tabBarView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: tabBarView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: tabBarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 49).isActive = true
        }
    }

}
