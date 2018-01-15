/*
 File: UIButtonExtension.swift
 Abstract: UIButton扩展[标题按钮、渐变按钮、纯色按钮]
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

extension UIButton {
    
    /// 仅带标题的按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - titleColor: 按钮标题颜色,高光颜色降低0.2透明度
    ///   - font: 字号,默认14
    /// - Returns: 标题按钮
    static func titleButton(title: String, titleColor: UIColor = UIColor.ColorSet.link, font: UIFont = UIFontMake(14)) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(UIColor(red: titleColor.red(), green: titleColor.green(), blue: titleColor.blue(), alpha: 0.8 * titleColor.alpha()), for: .highlighted)
        button.titleLabel?.font = font
        return button
    }
    
    
    /// 纯色背景按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - backgroundColor: 按钮背景色
    ///   - font: 字号,默认16
    /// - Returns: 纯色背景按钮
    static func pureColorButton(title: String, backgroundColor: UIColor = UIColor.ColorSet.weChat, font: UIFont = UIFontMake(16)) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(UIImage(color: backgroundColor), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = font
        return button
    }
    
    
    /// 水平方向渐变按钮
    ///
    /// - Parameters:
    ///   - colors: 渐变色值数组
    ///   - buttonSize: 按钮文字字号
    ///   - buttonTitle: 按钮大小
    /// - Returns: 渐变按钮
    static func gradientButton(fromColors colors: [UIColor], buttonSize: CGSize, buttonTitle: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIImage.gradientImage(fromColors: colors, imageSize: buttonSize), for: .normal)
        /*
        var highlightedColors = [UIColor]()
        for color in colors {
            let highlightedColor = UIColor(red: color.red(), green: color.green(), blue: color.blue(), alpha: 0.8 * color.alpha())
            highlightedColors.append(highlightedColor)
        }
        button.setBackgroundImage(UIImage.gradientImage(fromColors: highlightedColors, imageSize: buttonSize), for: .highlighted)
        */
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFontMake(18)
        button.setTitle(buttonTitle, for: .normal)
        
        return button
    }
}
