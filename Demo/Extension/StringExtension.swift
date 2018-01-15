/*
 File: StringExtension.swift
 Abstract: String扩展[计算文字大小]
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

extension String {
    
    /// 计算文字的大小
    ///
    /// - Parameters:
    ///   - size: 初始大小
    ///   - fontsize: 字号
    /// - Returns: 文字大小
    func boundingSize(_ size: CGSize, fontsize: CGFloat) -> CGSize {
        let text = self as NSString
        let originSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFontMake(fontsize)], context: nil).size
        return CGSize(width: ceil(originSize.width), height: ceil(originSize.height))
    }
    
    
    /// 计算文字宽度
    ///
    /// - Parameter fontsize: 字号
    /// - Returns: 文字宽度
    func boundingWidth(fontsize: CGFloat) -> CGFloat {
        return self.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude, height: fontsize), fontsize: fontsize).width
    }
}
