//
//  BottomToolbarController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomToolbarController: BaseViewController, UITableViewDataSource {

    lazy var bottomToolbar: BottomToolbar = {
        let bottomToolbar = BottomToolbar()
        bottomToolbar.backgroundColor = UIColor.white
        return bottomToolbar
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
        view.addSubview(bottomToolbar)
    }
    
    override func viewDidLayoutSubviews() {
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            bottomToolbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            //底部贴紧安全区域底部
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            //右侧紧贴父视图右侧
            bottomToolbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            //高度为60
            bottomToolbar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint(item: bottomToolbar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bottomToolbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44).isActive = true
        }
    }
}

// Mark - UITableViewDataSource

extension BottomToolbarController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        
        return cell
    }
}
