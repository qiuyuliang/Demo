//
//  TopToolbarCell.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/10.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class TopToolbarCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel(frame: self.contentView.bounds)
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColorMake(0x008AFF)
        titleLabel.font = UIFontMake(13)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = Helper.pixelOne
        contentView.layer.cornerRadius = 2
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
    }
    
    func configureCell(withSelected selected: Bool ,titleText: String)  {
        titleLabel.text = titleText
        if selected {
            contentView.layer.borderColor = UIColor.ColorSet.weChat.cgColor
            titleLabel.textColor = UIColor.ColorSet.weChat
        } else {
            contentView.layer.borderColor = UIColorMake(0xBDC3C4).cgColor
            titleLabel.textColor = UIColorMake(0x394043)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func widthForItem(title: String) -> CGFloat {
        return title.boundingWidth(fontsize: 13) + 20
    }
}
