//
//  LoginViewController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/9.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        let loginFooterView = LoginFooterView(frame: CGRect.zero)
        loginFooterView.sizeToFit()
        loginFooterView.loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        tableView.tableFooterView = loginFooterView;
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var loginBottomView: LoginBottomView = {
        let loginBotttomView = LoginBottomView()
        loginBotttomView.findPwdButton.addTarget(self, action: #selector(findPwdAction(_:)), for: .touchUpInside)
        return loginBotttomView
    }()

    
    // MARK: - LifeCycle
    
    deinit {
//        print("LoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        
        // Do any additional setup after loading the view.
        navigationItem.title = "登录";
        
        view.addSubview(tableView)
        
        view.addSubview(loginBottomView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loginBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
        if #available(iOS 11.0, *) {
            loginBottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loginBottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            NSLayoutConstraint(item: loginBottomView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            view.addConstraint(NSLayoutConstraint(item: loginBottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        }
    }
    
    
    // MARK: - IBActions
    
    @objc func loginAction(_ sender : AnyObject) {
        let frameworkManager = FrameworkManager.sharedInstance
        frameworkManager .toHomeFramework()
    }
    
    @objc func findPwdAction(_ sender: AnyObject) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension LoginViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
