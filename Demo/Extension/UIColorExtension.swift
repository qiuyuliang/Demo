/*
 File: UIColorExtension.swift
 Abstract: UIColor扩展[十六进制颜色、随机颜色、颜色集]
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

extension UIColor {
    
    /// 十六进制颜色便利构造器
    ///
    /// - Parameters:
    ///   - hex: 十六进制色值，以0x开头
    ///   - alpha: 透明度,默认不透明
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / CGFloat(255)
        let green = CGFloat((hex & 0x00FF00) >> 8) / CGFloat(255)
        let blue = CGFloat(hex & 0x0000FF) / CGFloat(255)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static var randomColor: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / CGFloat(255), green: CGFloat(arc4random_uniform(256)) / CGFloat(255), blue: CGFloat(arc4random_uniform(256)) / CGFloat(255), alpha: 1);
    }

    
    /// 获取rgb具体色值
    ///
    /// - Returns: 红色色值
    func red() -> CGFloat {
        return self.cgColor.components![0]
    }
    
    /// 获取rgb具体色值
    ///
    /// - Returns: 绿色色值
    func green() -> CGFloat {
        return self.cgColor.components![1]
    }
    
    /// 获取rgb具体色值
    ///
    /// - Returns: 蓝色色值
    func blue() -> CGFloat {
        return self.cgColor.components![2]
    }
    
    /// 获取透明度
    ///
    /// - Returns: 透明度
    func alpha() -> CGFloat {
        return self.cgColor.components![3]
    }
}

extension UIColor {
    /// 颜色集
    struct ColorSet {
        /// 微信绿
        static let weChat = UIColor(hex: 0x1EA114)
        /// 链接颜色
        static let link = UIColor(hex: 0x465481)
    }
}
