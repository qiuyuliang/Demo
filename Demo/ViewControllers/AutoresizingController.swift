//
//  AutoresizingController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/10.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class AutoresizingController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AutoresizingCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        view.addSubview(tableView)
    }

}


// Mark - UITableViewDataSource

extension AutoresizingController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

// Mark - UITableViewDelegate

extension AutoresizingController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
