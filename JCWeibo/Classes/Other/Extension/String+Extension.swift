//
//  String+Extension.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

extension String {
    /**
     快速拼接一个缓存目录的路径
     
     - returns: 拼接好的路径
     */
    func cacheDir() -> String {
        // 1.获取系统路径
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        // 2.拼接路径
        return (path as NSString).appendingPathComponent(self)
    }
    /**
     快速拼接一个文档目录的路径
     
     - returns: 拼接好的路径
     */
    func docDir() -> String {
        // 1.获取系统路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        // 2.拼接路径
        return (path as NSString).appendingPathComponent(self)
    }
    /**
     快速拼接一个临时目录的路径
     
     - returns: 拼接好的路径
     */
    func tmpDir() -> String {
        // 1.获取系统路径
        let path = NSTemporaryDirectory()
        
        // 2.拼接路径
        return (path as NSString).appendingPathComponent(self)
    }
}
