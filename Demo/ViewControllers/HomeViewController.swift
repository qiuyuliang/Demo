//
//  HomeViewController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/9.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    lazy var dataArray : [String] = {
        let dataArray = ["AutoResizing的使用", "顶部控件的布局", "底部toolbar的布局", "底部view的布局", "聊天输入框的适配", "自定义tabBar的布局"];
        return dataArray
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "消息"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(logoutAction(_:)))
        view.addSubview(tableView)
    }
    
    @objc func logoutAction(_ sender: AnyObject) {
        let frameworkManager = FrameworkManager.sharedInstance
        frameworkManager.toLoginFramework()
    }
}


// MARK: - UITableViewDataSource

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        tableViewCell.textLabel?.text = dataArray[indexPath.row]
        return tableViewCell
        
    }
}


// MARK: - UITableViewDelegate

extension HomeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = dataArray[indexPath.row] as String
        
        if title == "AutoResizing的使用" {
            let autoresizingVC = AutoresizingController()
            autoresizingVC.navigationItem.title = "AutoresizingController"
            navigationController?.pushViewController(autoresizingVC, animated: true)
        } else if title == "顶部控件的布局" {
            let topToolbarVC = TopToolbarController()
            topToolbarVC.navigationItem.title = "TopToolbarController"
            navigationController?.pushViewController(topToolbarVC, animated: true)
        } else if title == "底部toolbar的布局" {
            let bottomToolbarVC = BottomToolbarController()
            bottomToolbarVC.navigationItem.title = "BottomToolbarController"
            navigationController?.pushViewController(bottomToolbarVC, animated: true)
        } else if title == "底部view的布局" {
            let bottomViewVC = BottomViewController()
            bottomViewVC.navigationItem.title = "BottomViewController"
            navigationController?.pushViewController(bottomViewVC, animated: true)
        } else if title == "聊天输入框的适配" {
            let keyboardVC = KeyboardViewController()
            keyboardVC.navigationItem.title = "KeyboardViewController"
            navigationController?.pushViewController(keyboardVC, animated: true)
        } else if title == "自定义tabBar的布局" {
            let bottomTabBarVC = BottomTabBarController()
            bottomTabBarVC.navigationItem.title = "BottomTabBarController"
            navigationController?.pushViewController(bottomTabBarVC, animated: true)
        }
        
    }
}
