//
//  AutoresizingCell.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/10.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class AutoresizingCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margin: CGFloat = 10    //距离右、下角的距离
        let fontsize: CGFloat = 14
        let title = "右下角"
        let titleWidth = title.boundingWidth(fontsize: fontsize) //控件宽度
        let contentViewWidth = contentView.bounds.size.width
        let contentViewHeight = contentView.bounds.size.height
        
        print("width:\(contentViewWidth) height:\(contentViewHeight)")
        //width:320.0 height:44.0
        
        let label = UILabel(frame: CGRect(x: contentViewWidth - titleWidth - margin, y: contentViewHeight - fontsize - margin, width: title.boundingWidth(fontsize: 14), height: fontsize))
        label.backgroundColor = UIColor.red
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        label.font = UIFontMake(14)
        label.text = title
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
