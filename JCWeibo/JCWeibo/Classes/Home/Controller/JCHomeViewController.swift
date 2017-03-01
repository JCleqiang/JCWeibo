//
//  JCHomeViewController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeViewController: JCVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupNav()
    }
    
    func setupNav() {
        navigationItem.titleView = filterNavBarButton
        
    }
    
    func filterNavBarButtonDidClick() {
        let popMenuTool = JLPopMenuTool()
        popMenuTool.menuArray = ["首页", "首页", "首页", "首页", "首页", "首页"]
        popMenuTool.delegate = self
        popMenuTool.show(from: filterNavBarButton)
    }
    
    lazy var filterNavBarButton: NSFilterNavBarButton = {
        let filterNavBarButton = NSFilterNavBarButton()
        filterNavBarButton.addTarget(self, action: #selector(filterNavBarButtonDidClick), for:.touchUpInside)
        filterNavBarButton.navTitle = "静持大师"
        
        return filterNavBarButton
    }()
}

extension JCHomeViewController: JLPopMenuToolDelegate {
    func popMenuTool(_ popMenuTool: JLPopMenuTool!, didSelectRowAt indexPath: IndexPath!) {
        JCLog(message: "点击菜单")
    }
}
