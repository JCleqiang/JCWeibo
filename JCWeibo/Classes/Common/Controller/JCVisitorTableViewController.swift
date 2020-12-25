//
//  JCVisitorTableViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCVisitorTableViewController: UITableViewController {
    
    /// 定义便利记录当前用户登录状态
    var isUserLogin = JCUserAccountViewModel.shareInstance.isUserLogin
    var visitorView: JCVisitorView?
    
    override func loadView() {
        //
        if isUserLogin {
            super.loadView()
            return
        }
        
        //
        visitorView = JCVisitorView()
        
        visitorView?.loginBtn.addTarget(self, action: #selector(loginBtnDicClick), for: .touchUpInside)
        visitorView?.registerBtn.addTarget(self, action: #selector(registerBtnDicClick), for: .touchUpInside)
        
        view = visitorView
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240.0/255, green: 240.0/255, blue: 240.0/255, alpha: 1.0)
 
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessNoti), name: NSNotification.Name(rawValue: JCLoginSuccessNotification), object: nil)
    }

    // MARK: Action
    @objc func loginBtnDicClick() {
        let oauth = JCMainNavigationController(rootViewController: JCOAuthViewController())
        present(oauth, animated: true, completion: nil)
        
    }
    
    @objc func registerBtnDicClick() {
        JCLog(message: "点击注册")
    }
    
    @objc func loginSuccessNoti()  {
        super.loadView()
    }
     

    
}
