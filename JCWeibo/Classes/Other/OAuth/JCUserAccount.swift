//
//  JCUserAccount.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

@objcMembers
class JCUserAccount: NSObject, NSCoding {
    /// 用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    /// access_token的生命周期，单位是秒数。
    var expires_in: Double = -1 {
        didSet{
            // 根据多少秒之后过期, 生成真正的过期时间
            expires_Date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    /// 真正过期时间
    var expires_Date: NSDate?
    
    /// 当前授权用户的UID。
    var uid: String?
    
    /// 用户昵称
    var screen_name: String?
    
    /// 用户头像URL字符串
    var avatar_large: String?
    
    /// 保存模型路径
    static  var filePath: String = "account.plist".cacheDir()
    
    // MAKR: - 生命周期方法
    init(dict: [String: AnyObject]) {
        super.init()
        print("llq001: \(dict)")
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //
    }
    

    /// 从文件中读取一个模型时调用
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
//        expires_in = aDecoder.decodeObject(forKey: "expires_in") as! Double
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as? NSDate
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    /// 将对象写入文件时调用
    func encode(with aCoder:NSCoder) {
//    func encodeWithCoder(aCoder: NSCoder) { 
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_Date, forKey: "expires_Date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large") 
    }

    override var description: String {
        let keys = ["access_token", "expires_in", "uid", "expires_Date", "screen_name", "avatar_large"]
        let dict = dictionaryWithValues(forKeys: keys)
        return "\(dict)"
    }
    
    // MAKR: - 内部控制方法
    /**
     写入对象
     
     - returns: 是否写入成功
     */
    func saveUserAccount() -> Bool {
        // 3.写入对象
        JCLog(message: JCUserAccount.filePath)
        return NSKeyedArchiver.archiveRootObject(self, toFile: JCUserAccount.filePath)
        
    }
}

/*
 ["expires_in": 157679999, "remind_in": 157679999, "access_token": 2.00uP_qRG2q1llD67acd6051b0T_9jC, "uid": 5760461782]
 */


/*
 ["lang": zh-cn, "verified_reason_url": , "province": 44, "bi_followers_count": 0, "friends_count": 60, "verified_source_url": , "allow_all_comment": 1, "id": 5760461782, "pagefriends_count": 0, "urank": 4, "profile_image_url": http://tva2.sinaimg.cn/crop.0.0.602.602.50/006hQjfUjw8ezmiqmet8vj30gq0gqace.jpg, "following": 0, "url": , "city": 1, "star": 0, "geo_enabled": 1, "screen_name": 静持大师, "description": , "followers_count": 14, "mbtype": 0, "created_at": Sun Nov 15 12:32:22 +0800 2015, "remark": , "block_app": 0, "domain": , "class": 1, "favourites_count": 7, "ptype": 0, "credit_score": 80, "idstr": 5760461782, "cover_image_phone": http://ww1.sinaimg.cn/crop.0.0.640.640.640/549d0121tw1egm1kjly3jj20hs0hsq4f.jpg, "user_ability": 0, "profile_url": u/5760461782, "weihao": , "follow_me": 0, "statuses_count": 19, "allow_all_act_msg": 0, "name": 静持大师, "insecurity": {
 "sexual_content" = 0;
 }, "verified_type": -1, "block_word": 0, "verified_reason": , "avatar_hd": http://tva2.sinaimg.cn/crop.0.0.602.602.1024/006hQjfUjw8ezmiqmet8vj30gq0gqace.jpg, "gender": m, "online_status": 0, "status": {
 annotations =     (
 {
 "mapi_request" = 1;
 }
 );
 "attitudes_count" = 0;
 "biz_feature" = 0;
 "comments_count" = 0;
 "created_at" = "Fri Feb 17 00:10:07 +0800 2017";
 "darwin_tags" =     (
 );
 favorited = 0;
 geo = "<null>";
 "gif_ids" = "";
 hasActionTypeCard = 0;
 "hot_weibo_tags" =     (
 );
 id = 4075932123410744;
 idstr = 4075932123410744;
 "in_reply_to_screen_name" = "";
 "in_reply_to_status_id" = "";
 "in_reply_to_user_id" = "";
 isLongText = 0;
 "is_show_bulletin" = 2;
 mid = 4075932123410744;
 mlevel = 0;
 "pic_urls" =     (
 );
 "positive_recom_flag" = 0;
 "reposts_count" = 0;
 source = "<a href=\"http://app.weibo.com/t/feed/2dFDRp\" rel=\"nofollow\">iPhone SE</a>";
 "source_allowclick" = 0;
 "source_type" = 1;
 text = "\U8f6c\U53d1\U5fae\U535a";
 "text_tag_tips" =     (
 );
 truncated = 0;
 userType = 0;
 visible =     {
 "list_id" = 0;
 type = 0;
 };
 }, "verified_trade": , "location": 广东 广州, "verified_source": , "verified": 0, "mbrank": 0, "avatar_large": http://tva2.sinaimg.cn/crop.0.0.602.602.180/006hQjfUjw8ezmiqmet8vj30gq0gqace.jpg]

 
 */
