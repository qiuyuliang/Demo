//
//  YLDB.swift
//  Demo
//
//  Created by 邱育良 on 2018/1/11.
//  Copyright © 2018年 www.qiuyuliang.com. All rights reserved.
//

import UIKit
import SQLite3

class YLDB: NSObject {
    
    var sqlite : OpaquePointer? = nil
    
    func openDB() {
        

        let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let path = (docDir as NSString).appendingPathComponent("db.sqlite")
        
        let cpath = path.cString(using:String.Encoding.utf8)
        let result = sqlite3_open(cpath!, &sqlite)
        if result != SQLITE_OK {
            print("打开数据库失败")
            return
        } else {
            print("打开数据库成功")
        }
    }
    
    

}
