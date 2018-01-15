//
//  BottomTabBarItemView.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/15.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class BottomTabBarItemView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var bottomTabBarItemInnerView: BottomTabBarItemInnerView = {
        let bottomTabBarItemInnerView = BottomTabBarItemInnerView()
        return bottomTabBarItemInnerView
    }()

    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(bottomTabBarItemInnerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomTabBarItemInnerView.translatesAutoresizingMaskIntoConstraints = false
        bottomTabBarItemInnerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        if #available(iOS 11.0, *) {
            bottomTabBarItemInnerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
}

class BottomTabBarItemInnerView: UIView {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFontMake(10)
        titleLabel.textColor = UIColor.ColorSet.weChat
        titleLabel.text = "first"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UITemplateImageMake("first"))
        imageView.tintColor = UIColor.ColorSet.weChat
        return imageView
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["titleLabel" : titleLabel, "imageView" : imageView] as [String : Any]
        let metric = ["separatorHeight" : 16]
        let constraints = [
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[imageView(30)]-2-[titleLabel]|",
                options: [.alignAllCenterX],
                metrics: nil,
                views: viewsDictionary
            ),
//            NSLayoutConstraint.constraints(
//                withVisualFormat: "H:|[imageView(30)|",
//                options: [],
//                metrics: metric,
//                views: viewsDictionary
//            ),
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[titleLabel(80)]|",
                options: [],
                metrics: metric,
                views: viewsDictionary
            )
        ]
        NSLayoutConstraint.activate(constraints.flatMap{ $0 })
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingCompressedSize
    }
    
}
