/*
 File: UIImageExtension.swift
 Abstract: UIImage扩展[纯色图片、渐变色图片、返回按钮图片、关闭按钮图片]
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

extension UIImage {
    
    /// 纯色图片
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    
    
    /// 水平方向渐变的图片
    ///
    /// - Parameters:
    ///   - colors: 渐变的颜色数组
    ///   - imageSize: 渐变区域的大小
    /// - Returns: 渐变图片
    static func gradientImage(fromColors colors: [UIColor], imageSize: CGSize) -> UIImage {
        var array = [CGColor]()
        for color in colors {
            array.append(color.cgColor)
        }
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let colorSpace = colors.last?.cgColor.colorSpace
        let gradinet = CGGradient.init(colorsSpace: colorSpace, colors: array as CFArray, locations: nil)
        let start = CGPoint(x: 0.0, y: 0.0)
        let end = CGPoint(x: imageSize.width, y: 0.0)
        context?.drawLinearGradient(gradinet!, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    /// 返回按钮图片
    ///
    /// - Parameters:
    ///   - tintColor: 返回按钮图片颜色
    ///   - imageSize: 返回按钮图片大小
    /// - Returns: 返回按钮图片
    static func backBarImage(tintColor: UIColor = UIColor.black, imageSize: CGSize = CGSize(width: 12, height: 20)) -> UIImage {
        let lineWidth: CGFloat = 2
        let drawOffset = lineWidth / 2
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: imageSize.width - drawOffset, y: drawOffset))
        path.addLine(to: CGPoint(x: drawOffset, y: imageSize.height / 2.0))
        path.addLine(to: CGPoint(x: imageSize.width - drawOffset, y: imageSize.height - drawOffset))
        
        context?.setStrokeColor(tintColor.cgColor)
        path.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()

        return image!
    }
    
    /// 关闭按钮图片
    ///
    /// - Parameters:
    ///   - tintColor: 关闭按钮图片颜色
    ///   - imageSize: 关闭按钮图片大小
    /// - Returns: 关闭按钮图片
    static func closeBarImage(tintColor: UIColor = UIColor.black, imageSize: CGSize = CGSize(width: 16, height: 16)) -> UIImage {
        let lineWidth: CGFloat = 1.2
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: imageSize.width, y: imageSize.height))
        path.close()
        
        path.move(to: CGPoint(x: imageSize.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: imageSize.height))
        path.close()
        
        context?.setStrokeColor(tintColor.cgColor)
        path.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
