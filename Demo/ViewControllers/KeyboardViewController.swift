//
//  KeyboardViewController.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/14.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class KeyboardViewController: BaseViewController {
    
    lazy var textInputBar: TextInputToolbar = {
        let textInputBar = TextInputToolbar()
        textInputBar.barTintColor = UIColor.white
        return textInputBar
    }()
    
    var hideConstraint: NSLayoutConstraint?
    var showConstraint: NSLayoutConstraint?

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(textInputBar)
        
        textInputBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            //左侧紧贴父视图左侧
            textInputBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            //键盘消失时底部贴紧安全区域底部
            hideConstraint = textInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            hideConstraint?.isActive = true
            
            //键盘出现时底部贴紧屏幕底部，该约束并未激活
            showConstraint = textInputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            showConstraint?.isActive = false
            
            //右侧紧贴父视图右侧
            textInputBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            //高度为40
            textInputBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: - IBActions
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        
        adjustTextFieldByKeyboardState(state: true, keyboardInfo: userInfo!)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        let userInfo = notification.userInfo
        adjustTextFieldByKeyboardState(state: false, keyboardInfo: userInfo!)
    }
    
    
    // MARK: - Private
    
    private func adjustTextFieldByKeyboardState(state: Bool, keyboardInfo: [AnyHashable : Any]) {
        
        if state {
            let keyboardFrameVal = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            
            let keyboardFrame = keyboardFrameVal.cgRectValue
            
            let height = keyboardFrame.size.height
            
            showConstraint?.constant = -height
            hideConstraint?.isActive = false
            showConstraint?.isActive = true
            
        } else {
            hideConstraint?.isActive = true
            showConstraint?.isActive = false
        }
        
        let animationDurationValue = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration = animationDurationValue.doubleValue
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
  
    }
}
