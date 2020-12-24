//
//  JCMainTabBarController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orange

        setupChildVcs();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        composeButton.center.x = tabBar.center.x
        
        composeButton.addTarget(self, action: #selector(composeButtonDidClick), for: .touchUpInside)
    }

    func setupChildVcs() {
        setUpChildViewController(vc: JCHomeViewController(), imageName: "tabbar_home", tabBarTitle: "首页")
        setUpChildViewController(vc: JCMessageViewController(), imageName: "tabbar_message_center", tabBarTitle: "消息")
        setUpChildViewController(vc: UIViewController(), imageName: "", tabBarTitle: "")
        setUpChildViewController(vc: JCDiscoverViewController(), imageName: "tabbar_discover", tabBarTitle: "发现")
        setUpChildViewController(vc: JCMeViewController(), imageName: "tabbar_profile", tabBarTitle: "我的")
    }
    
    func setUpChildViewController(vc: UIViewController, imageName: String, tabBarTitle: String)  {
        
        let navVC = JCMainNavigationController(rootViewController: vc)
        
        navVC.tabBarItem.image = UIImage(named: imageName)
        navVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        navVC.tabBarItem.title = tabBarTitle;
        
        addChildViewController(navVC)
    }
    
    // MARK: Action
    // 为了提升性能了,Swift会在编译时确定的方法和属性, 如果想让Swift支持OC的动态派发那么必须在前面加上@objc
    @objc private func composeButtonDidClick() {
        JCLog(message: "发送按钮点击")
    }

    // MARK: Lazy
    private lazy var composeButton: UIButton = {
        let btn = UIButton()
        
        let bgImg = "tabbar_compose_button"
        btn.setBackgroundImage(UIImage(named: bgImg), for: .normal)
        btn.setBackgroundImage(UIImage(named: bgImg + "_highlighted"), for: .highlighted)
        
        let img = "tabbar_compose_icon_add"
        btn.setImage(UIImage(named: img), for: .normal)
        btn.setImage(UIImage(named: img + "_highlighted"), for: .highlighted)
        
        btn.sizeToFit()
        
        return btn
    }()
}
