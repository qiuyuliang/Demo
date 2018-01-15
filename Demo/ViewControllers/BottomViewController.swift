//
//  BottomViewController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomViewController: BaseViewController, UITableViewDataSource {

    lazy var bottomView: BottomView = {
        let bottomView = BottomView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tableView
    }()
    

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        view.addSubview(bottomView)
    }
    
    override func viewDidLayoutSubviews() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            //底部贴紧屏幕底部
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            //右侧紧贴父视图右侧
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            //顶部距离安全区域底部为44
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint(item: bottomView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        }
    }

}

// Mark - UITableViewDataSource

extension BottomViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        
        return cell
    }
}
