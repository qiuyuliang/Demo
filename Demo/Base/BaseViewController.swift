/*
 File: BaseViewController.swift
 Abstract: 所有自定义控制器的基类
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

class BaseViewController: UIViewController {

    
    // MARK: - LifeCycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
//        print(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
    }
    
    
    // MARK: - Override
    //为每个模态视图添加关闭按钮
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        if viewControllerToPresent.isKind(of: UINavigationController.classForCoder()) {
            let viewController = viewControllerToPresent as! UINavigationController
            
            let close = UIImage.closeBarImage()
            
            viewController.topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: close, style: .plain, target: self, action: #selector(cancelAction(_:)))
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    
    // MARK: - IBActions
    @objc func cancelAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
