//
//  TopToolbarController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/10.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class TopToolbarController: BaseViewController, UITableViewDataSource {

    lazy var topToolbar: TopToolbar = {
        let topToolbar = TopToolbar()
        return topToolbar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        view.addSubview(topToolbar)
    }
    
    override func viewDidLayoutSubviews() {
        topToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            topToolbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            topToolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
            topToolbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            let viewsDictionary = ["topToolbar" : topToolbar, "topLayoutGuide" : topLayoutGuide ] as [String : Any]
            let constraints = [
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[topLayoutGuide][topToolbar(44)]",
                    options: [],
                    metrics: nil,
                    views: viewsDictionary
                ),
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[topToolbar]|",
                    options: [],
                    metrics: nil,
                    views: viewsDictionary
                )
            ]
            NSLayoutConstraint.activate(constraints.flatMap{ $0 })
        }
    }
}


// Mark - UITableViewDataSource

extension TopToolbarController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        
        return cell
    }
}
