/*
 File: FrameworkManager.swift
 Abstract: 框架切换辅助单例
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit

typealias LoginFrameworkHandle = () -> Void
typealias HomeFrameworkHandle = () -> Void

class FrameworkManager: NSObject {
    
    var loginFrameworkHandle : LoginFrameworkHandle?
    var homeFrameworkHandle : HomeFrameworkHandle?
    
    // MARK: - 单例
    static let sharedInstance = FrameworkManager()
    private override init() {}
    
    
    /// 跳转到登录页面
    public func toLoginFramework() {
        if loginFrameworkHandle != nil {
            loginFrameworkHandle!()
        }
    }
    
    /// 跳转到主框架
    public func toHomeFramework() {
        if homeFrameworkHandle != nil {
            homeFrameworkHandle!()
        }
    }
}
