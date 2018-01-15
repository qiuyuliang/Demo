/*
 File: BaseNavigationController.swift
 Abstract: 所有自定义导航控制器的基类,提供一个自定义的返回按钮并支持边缘手势返回
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.tintColor = UIColor.ColorSet.weChat
        self.interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            
            let backBarImage = UIImage.backBarImage()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backBarImage, style: .plain, target: self, action: #selector(popAction(_:)))
            if childViewControllers.count == 1 {
                viewController.hidesBottomBarWhenPushed = true
            }
        }
        
        super.pushViewController(viewController, animated: animated)
        
        //修复iOS 11 中push时tabBar向上移动的bug
        if let _tabBarController = tabBarController {
            var frame = _tabBarController.tabBar.frame
            frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
            _tabBarController.tabBar.frame = frame
        }
    }
    
    
    // MARK: - IBActions
    
    @objc func popAction(_ sender: AnyObject) {
        self.popViewController(animated: true)
    }
}


// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count > 1 {
            return true
        } else {
            return false
        }
    }
}
