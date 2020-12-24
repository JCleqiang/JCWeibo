//
//  UIBarButtonItem+Extension.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String,target: AnyObject, action: Selector) {
        // 1.创建按钮
        let btn = UIButton(imageName: imageName, backgroundImageName: "")
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // 2.根据按钮创建item
        self.init(customView: btn)
    }
}

