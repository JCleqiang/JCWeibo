//
//  JCPicture.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCPicture: NSObject {

    /// 配图字符串地址
    var thumbnail_pic: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["thumbnail_pic"]
        let dict = dictionaryWithValues(forKeys: keys)
        return "\(dict)"
    }
}
