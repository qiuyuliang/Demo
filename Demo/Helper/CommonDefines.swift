/*
 File: CommonDefines.swift
 Abstract: 一些常用的定义
 Version: 1.0
 Created By: 邱 育良
 Copyright (C) 2018 Qiu Yuliang. All Rights Reserved.
 
 */

import UIKit


/// 十六进制颜色设置
let UIColorMake : (UInt32) -> UIColor = { UIColor(hex: $0) }

/// 带透明度的十六进制颜色设置
let UIColorAlphaMake : (UInt32, CGFloat) -> UIColor = { UIColor(hex: $0, alpha: $1) }

/// 字号设置
let UIFontMake : (CGFloat) -> UIFont = { UIFont.systemFont(ofSize: $0) }

/// 图片设置
let UIImageMake : (String) -> UIImage = { UIImage(named: $0)!}

/// 模板图片设置，通过设置tintColor可以更改图片颜色
let UITemplateImageMake : (String) -> UIImage = { UIImage(named: $0)!.withRenderingMode(.alwaysTemplate)}
