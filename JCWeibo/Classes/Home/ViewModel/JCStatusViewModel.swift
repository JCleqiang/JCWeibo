//
//  JCStatusViewModel.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
 
class JCStatusViewModel: NSObject {
    /// 数据模型
    var statusModel: JCStatusModel
    
    init(statusModel: JCStatusModel) {
        self.statusModel = statusModel
    }
    
    /// 保存头像
    var AvatarURL: NSURL? {
        return NSURL(string: statusModel.userModel?.profile_image_url ?? "")
    }
    
    /// 认证图标
    var verifiedImage: UIImage? {
        
        let type = statusModel.userModel?.verified_type ?? -1
        switch type {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2, 3, 5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    
    /// 会员图标
    var vipImage: UIImage? {
        
        let rank = statusModel.userModel?.mbrank ?? 0
        if  rank > 0 && rank < 7 {
            return UIImage(named: "common_icon_membership_level\(rank)")
        }
        return nil
    }
    
    /// 时间
    var timeStr: String? {
        // 1.将字符串转换为NSDate 
        if let createDate = NSDate.createDateWithString(str: statusModel.created_at ?? "") {
            // 2.设置时间
            return createDate.descString()
        }
        return nil
    }
    
    /// 来源
    var sourceStr: String? {
        let text: String = statusModel.source ?? ""
        
        if text != "" {
            let text = text as NSString
            let startIndex = text.range(of: ">").location + 1
            let length = text.range(of: "<", options: .backwards).location - startIndex
            let result = text.substring(with: NSMakeRange(startIndex, length))

            return "来自: " + result 
        }
        
        return text
    }
    
    /// 当前微博所有配图URL数组
    var thumbnail_urls: [NSURL]? {
        guard let array = statusModel.retweeted_status?.pic_urls ?? statusModel.pic_urls else {
            return nil
        }
         
        var models = [NSURL]()
        for pic in array {
            let url = NSURL(string: pic.thumbnail_pic ?? "")!
            models.append(url)
        }
        return models
    }
    
    /// 当前微博所有配图大图URL数组
    var large_urls: [NSString]? {
        //安全校验
        guard let array = statusModel.retweeted_status?.pic_urls ?? statusModel.pic_urls else {
            return nil
        }
        
        var models = [NSString]()
        for pic in array {
            // 取出当前配图的URL字符串
            guard var temp =  pic.thumbnail_pic else{
                continue
            }
            // 将当前URL字符串中的thumbnail替换为large
            temp = (temp as NSString).replacingOccurrences(of: "thumbnail", with: "large") 
            models.append(temp as NSString)
        }
        return models
    }

    
    // 获取微博数据
    class func loadStatuesData(since_id: Int, max_id: Int, finished: @escaping (_ array: [[String: Any]]?, _ error: NSError?)->()) {
        
        let path = "2/statuses/home_timeline.json"
        let parameters: [String : Any] = ["access_token": JCUserAccountViewModel.shareInstance.access_token!, "since_id": since_id, "max_id": max_id]
        
        JCNetworking.sharedInstance.getRequest(urlString: path, params: parameters, success: { (response) in
            guard let dict = response as? [String: AnyObject] else {
                finished(nil, NSError(domain: "", code: 1001, userInfo: ["message": "服务器是返回的数据不是字典"]))
                return
            }
            // 2.从字典中取出所有微博数据
            guard let array = dict["statuses"] as? [[String: AnyObject]] else {
                finished(nil, NSError(domain: "", code: 1001, userInfo: ["message": "字典中没有statuses这个key"]))
                return
            }
            
            // 3.返回结果
            finished(array, nil)
            
        }) { (error) in
            finished(nil, error as NSError)
        }
    }
    

}
