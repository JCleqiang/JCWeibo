//
//  JCMainNavigationController.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCMainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
 
    override class func initialize() {
        
        let navBar = UINavigationBar.appearance()
        
        // 设置导航栏变得不透明使得视图的坐标的原点从导航栏下边缘开始，也可以设置背景图片达到这个效果
        navBar.isTranslucent = false
        
        navBar.tintColor = UIColor.orange
        
        let dict: [String: Any] = [NSForegroundColorAttributeName: UIColor.black,
                                   NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
        navBar.titleTextAttributes = dict
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = childViewControllers.count != 0
        
        super.pushViewController(viewController, animated: animated)
    }
}

