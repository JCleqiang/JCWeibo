//
//  JCStatusModel.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCStatusModel: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = -1
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 当前微博对应的用户
    var userModel: JCUserModel?
    /// 当前微博所有配图
    var pic_urls: [JCPicture]?
    
    /// 转发微博
    var retweeted_status: JCStatusModel?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //
    }

    /// KVC的setValuesForKeysWithDictionary方法内部其实是调用以下方式实现赋值
    // 注意点: KVC默认的实现是将取到的值直接赋值给对应的属性, 如果想自定义一些操作可以重写以下方法, 拦截对应的key, 做自定义操作
    override func setValue(_ value: Any?, forKey key: String) {
        // 1.拦截user这个key, 如果是user这个key就直接处理
        if key == "user" {
            userModel = JCUserModel(dict: value as! [String : AnyObject])
            return
        }else if key == "pic_urls" {
            var models = [JCPicture]()
            for dict in (value as! [[String: AnyObject]]) {
                models.append(JCPicture(dict: dict))
            }
            pic_urls = models
            return
        }else if key == "retweeted_status" {
            retweeted_status = JCStatusModel(dict: value as! [String : AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override var description: String {
        let keys = ["created_at", "id", "text", "source"]
        let dict = dictionaryWithValues(forKeys: keys)
        return "\(dict)"
    }
    
    }
