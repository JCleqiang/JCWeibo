//
//  AppDelegate.swift
//  JCWeibo
//
//  Created by 23 on 2017/3/1.
//  Copyright © 2017年 23. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: 属性
    var window: UIWindow?

    // MARK: 方法
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 创建窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.red
        window?.rootViewController = JCMainTabBarController()
        
        // 显示窗口
        window?.makeKeyAndVisible()
        
        //
        config_nav()
        
        return true
    }
     
    
    func config_nav() {
        let navBar = UINavigationBar.appearance()
        
        // 设置导航栏变得不透明使得视图的坐标的原点从导航栏下边缘开始，也可以设置背景图片达到这个效果
        navBar.isTranslucent = false
        
        navBar.tintColor = UIColor.black
        
        let dict: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        navBar.titleTextAttributes = dict
    }
}

func JCLog<T> (message: T, file: String = #file, method: String = #function, line: Int = #line) {
    // 1.处理文件名称
    let fileName = (file as NSString).pathComponents.last!
    print("\(fileName)-\(method)[\(line)]: \(message)")
}

