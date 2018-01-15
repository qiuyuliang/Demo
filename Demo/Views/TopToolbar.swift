//
//  TopToolbar.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/10.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit

class Item {
    var title : String?
    var selected = false
    
    convenience init(title: String, selected: Bool) {
        self.init()
        self.title = title
        self.selected = selected
    }
}


class TopToolbar: UIToolbar, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let topToolbarIndentifier = "topToolbarIndentifier"
    
    lazy var dataArray: [Item] = {
        var dataArray = [Item]()
        dataArray.append(Item(title: "iPhone X", selected: true))
        dataArray.append(Item(title: "iPhone 8 Plus", selected: false))
        dataArray.append(Item(title: "iPhone 8", selected: false))
        dataArray.append(Item(title: "iPhone 7 Plus", selected: false))
        dataArray.append(Item(title: "iPhone 7", selected: false))
        dataArray.append(Item(title: "iPhone SE", selected: false))
        dataArray.append(Item(title: "iPhone 6s Plus", selected: false))
        dataArray.append(Item(title: "Phone 6s", selected: false))
        dataArray.append(Item(title: "iPhone 6 Plus", selected: false))
        dataArray.append(Item(title: "iPhone 6", selected: false))
        dataArray.append(Item(title: "iPhone 5s", selected: false))
        dataArray.append(Item(title: "iPhone 5c", selected: false))
        dataArray.append(Item(title: "iPhone 5", selected: false))
        dataArray.append(Item(title: "iPhone 4S", selected: false))
        dataArray.append(Item(title: "iPhone 4", selected: false))
        dataArray.append(Item(title: "iPhone 3G", selected: false))
        dataArray.append(Item(title: "iPhone 2G", selected: false))
        dataArray.append(Item(title: "iPhone", selected: false))
        return dataArray
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 87, height: 32)
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 9
        flowLayout.scrollDirection = .horizontal
        
        var collectionView: UICollectionView
        if #available(iOS 11.0, *) {
            
            collectionView = UICollectionView(frame: self.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: flowLayout)
        } else {
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        }
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TopToolbarCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for view in subviews {
            if view .isKind(of: NSClassFromString("_UIToolbarContentView")!) {
                view.isUserInteractionEnabled = false
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize.init(width: size.width, height: 44)
    }
    
}

extension TopToolbar {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = dataArray[indexPath.item]
        
        return CGSize(width: TopToolbarCell.widthForItem(title: item.title!), height: 32)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopToolbarCell
        
        let item = dataArray[indexPath.item]
        cell.configureCell(withSelected: item.selected, titleText: item.title!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var i = 0
        for item in dataArray {
            if indexPath.item == i {
                item.selected = true
            } else {
                item.selected = false
            }
            i = i + 1
        }
        collectionView.reloadData()
    }
}
