//
//  JCOAuthViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SVProgressHUD

let JC_App_Key = "3409459236"
let JC_App_Secret = "7435c6c91b8c14b616e5b0d7f5f6e44e"
let JC_Redirect_uri = "http://www.qq.com"

class JCOAuthViewController: UIViewController {

    override func loadView() {
        view = webView
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 0.添加导航条按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(JCOAuthViewController.closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(JCOAuthViewController.autoAccount))
    
        let str = "https://api.weibo.com/oauth2/authorize?client_id=\(JC_App_Key)&redirect_uri=\(JC_Redirect_uri)"
        let url = NSURL(string: str)!
        let request = NSURLRequest(url: url as URL)
        webView.loadRequest(request as URLRequest)
    }

    // MAKR: - 内部控制方法
    @objc func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func autoAccount() {
        // 1.编写JS语句
        let jsStr = "document.getElementById('userId').value='17093436954';" + "document.getElementById('passwd').value='a5816660';"
        // 2.执行JS语句
        webView.stringByEvaluatingJavaScript(from: jsStr)
    }

    // MAKR: - 懒加载
    private lazy var webView = UIWebView()
}

extension JCOAuthViewController: UIWebViewDelegate {
    /// 每次请求都会调用, 要求返回一个Bool类型的值
    /// 如果返回false代表不允许访问, 如果返回true代表允许访问
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        // 1.回调页守护
        guard let urlStr = request.url?.absoluteString else {
            closeBtnClick()
            return false
        }
        
        // 1.2判断是否是授权回调页
        if !urlStr.hasPrefix(JC_Redirect_uri) {
            return true
        }
        
        // 2.判断是否是
        if !urlStr.contains("error_uri=") {
            // 2.1获取code=所在的位置
            guard let range = urlStr.range(of: "code=") else {
                closeBtnClick()
                return false
            }
            // 2.2截取字符串
            let code = urlStr.substring(from: range.upperBound) 
             
            // 2.3利用RequestToken换取AccessToken
            loadAccessToken(code: code)
        }
        
        // 3.关闭授权界面
        closeBtnClick()
        return false
    }
    /// 每次请求之前调用
    func webViewDidStartLoad(_ webView: UIWebView) { 
        SVProgressHUD.showInfo(withStatus: "正在加载...")
    }
    /// 每次请求完毕之后调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /**
     授权
     */
    private func loadAccessToken(code: String){
        // 根据授权码code获取token
        JCUserAccountViewModel.shareInstance.loadAccessToken(code: code, finished: { (account, error) -> () in 
            
            // 2.授权成功, 获取用户信息
            JCUserAccountViewModel.shareInstance.loadUserInfo(account: account!, finished: { (account, error) -> () in
                
                // 1.安全校验
                if error != nil || account == nil {
                    SVProgressHUD.showError(withStatus: "获取授权信息失败")
                    return
                } 
                
                // 2.保存授权模型
                if account!.saveUserAccount() == false {
                    SVProgressHUD.showError(withStatus: "写入账号失败")
                    return
                } 
                JCUserAccountViewModel.shareInstance.account = account!
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: JCLoginSuccessNotification), object: false)
                
                // 4.关闭当前界面
                self.closeBtnClick()
            })
            
        })
    }

}
