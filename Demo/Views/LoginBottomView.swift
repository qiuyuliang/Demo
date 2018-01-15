//
//  LoginBottomView.swift
//  Demo
//  //找回密码|紧急冻结|更多选项
//  Created by 邱育良 on 2018/1/9.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class LoginBottomView: UIView {
    
    lazy var findPwdButton: UIButton = {
        let button = UIButton.titleButton(title: "找回密码")
        return button
    }()
    
    lazy var separatorLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorMake(0x465481)
        return view
    }()
    
    lazy var freezeButton: UIButton = {
        let button = UIButton.titleButton(title: "紧急冻结")
        return button
    }()
    
    lazy var separatorLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColorMake(0x465481)
        return view
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton.titleButton(title: "更多选项")
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //找回密码按钮
        findPwdButton.translatesAutoresizingMaskIntoConstraints = false
        //紧急冻结按钮
        freezeButton.translatesAutoresizingMaskIntoConstraints = false
        //更多选项按钮
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        //两条分割线
        separatorLine1.translatesAutoresizingMaskIntoConstraints = false
        separatorLine2.translatesAutoresizingMaskIntoConstraints = false

        let viewsDictionary = ["findPwdButton" : findPwdButton, "freezeButton" : freezeButton, "moreButton" : moreButton, "separatorLine1" : separatorLine1, "separatorLine2" : separatorLine2]
        let metric = ["separatorHeight" : 16]
        let constraints = [
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[findPwdButton]-[separatorLine1(1)]-[freezeButton]-[separatorLine2(1)]-[moreButton]|",
                options: [.alignAllTop, .alignAllBottom],
                metrics: nil,
                views: viewsDictionary
            ),
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[separatorLine1(separatorHeight)]|",
                options: [],
                metrics: metric,
                views: viewsDictionary
            )
        ]
        NSLayoutConstraint.activate(constraints.flatMap{ $0 })
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            addSubview(findPwdButton)
            addSubview(freezeButton)
            addSubview(moreButton)
            addSubview(separatorLine1)
            addSubview(separatorLine2)

        }
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingCompressedSize
    }

}
