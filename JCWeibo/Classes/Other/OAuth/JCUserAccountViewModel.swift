//
//  JCUserAccountViewModel.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCUserAccountViewModel: NSObject {
    // 单利
    static let shareInstance: JCUserAccountViewModel = JCUserAccountViewModel()
    
    /// 授权模型
    var account: JCUserAccount?
    
    var screen_name: String? {
        return account?.screen_name
    }
    
    var access_token: String? {
        return account?.access_token
    }
    
    /// 记录授权模型是否过期
    var isExpires: Bool {
        let date: Date = Date.init()
        if account?.expires_Date?.compare(date) == ComparisonResult.orderedAscending {
            return true
        }
        return false
    }
    
    /**
     判断用户是否登录
     */
    var isUserLogin: Bool {
        if account == nil {
            return false
        }
        
        if account!.access_token == nil {
            return false
        }
        
        return true
    }
     
    override init() {
        super.init()
        
        // 1.读取对象
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: JCUserAccount.filePath) as? JCUserAccount
        
        // 2.判断是否过期
        if self.isExpires  {
            return
        }
        
        // 3.保存授权模型
        self.account = account
    }
    
    /**
     利用RequestToken换取AccessToken
     
     - parameter code: RequestToken
     */
    func loadAccessToken(code: String, finished: @escaping (_ account: JCUserAccount?, _ error: NSError?)->()) {
        let path = "oauth2/access_token"
        let parameters = ["client_id": JC_App_Key,
                          "client_secret": JC_App_Secret,
                          "grant_type": "authorization_code",
                          "code": code,
                          "redirect_uri": JC_Redirect_uri] 
        
        JCNetworking.sharedInstance.postRequest(urlString: path, params: parameters, success: { (response) in
            // 3.2字典转换模型
            let account = JCUserAccount(dict: response)
            if account.access_token == nil {
                account.access_token = response["access_token"] as? String
                account.expires_in = response["expires_in"] as? Double ?? 0
                account.uid = response["uid"] as? String
            }
            
            finished(account, nil)
            
        }) { (error) in
            finished(nil, error as NSError?)
        }
    }
    
    /**
     获取用户信息
     
     - parameter account: 授权模型
     */
    func loadUserInfo(account: JCUserAccount, finished: @escaping (_ account: JCUserAccount?, _ error: NSError?)->()) {
        // 断言就是断定前面的条件一定成立, 如果不成立, 那么程序就会崩溃, 并且会在控制台数据后面的message
        assert(account.access_token != nil, "必须授权之后才能调用")
        assert(account.uid != nil, "必须授权之后才能调用")
        
        let path = "2/users/show.json"
        let parameters = ["access_token": account.access_token!,
                          "uid": account.uid!]
        
        JCNetworking.sharedInstance.getRequest(urlString: path, params: parameters, success: { (response) in
            print("用户信息: ")
            print(response)
            
            account.screen_name = response["screen_name"] as? String
            account.avatar_large = response["avatar_large"] as? String 
            
            finished(account, nil)
            
        }) { (error) in
            finished(nil, error as NSError?)
        }
        
    }
}
