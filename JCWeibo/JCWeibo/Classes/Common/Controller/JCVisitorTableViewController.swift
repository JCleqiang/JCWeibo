//
//  JCVisitorTableViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCVisitorTableViewController: UITableViewController {
    
    var isLogin = false
    var visitorView: JCVisitorView?
    
    override func loadView() {
        if isLogin {
            super.loadView()
        }
        else {
            visitorView = JCVisitorView()
            
            visitorView?.loginBtn.addTarget(self, action: #selector(loginBtnDicClick), for: .touchUpInside)
            visitorView?.registerBtn.addTarget(self, action: #selector(registerBtnDicClick), for: .touchUpInside)
            
            view = visitorView
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Action
    func loginBtnDicClick() {
        JCLog(message: "点击登录")
    }
    
    func registerBtnDicClick() {
        JCLog(message: "点击注册")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
