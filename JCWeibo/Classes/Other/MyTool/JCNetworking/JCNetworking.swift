//
//  JCNetworking.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import Alamofire

private let shareInstance = JCNetworking()

class JCNetworking: NSObject  {
    class var sharedInstance : JCNetworking {
        return shareInstance
    }
}

extension JCNetworking {
    
    
    func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        Alamofire.request(JC_Base_URL + urlString, method: .get, parameters: params).responseJSON { (response) in
            //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                switch response.result {
                case .success(let value):
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                    
                    success(value as! [String : AnyObject])
//                    print(value)
                    
                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
        } 
    }
    
    //MARK: - POST 请求
    func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(JC_Base_URL + urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                print(response)
                
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                    
                    print(value)
                }
            case .failure(let error):
                print("error:\(error)")
                failture(error)
            }
            
        }
    }
}
