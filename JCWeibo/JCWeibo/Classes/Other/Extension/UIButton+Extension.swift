//
//  UIButton+Extension.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        
        // 设置图标
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        // 设置背景
        setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), for: .highlighted)
        
        // 调整按钮尺寸
        sizeToFit()
    }
    
    convenience init(title: String, backgroundImageName: String, color: UIColor){
        self.init()
        
        setTitle(title, for: .normal)
        setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        setTitleColor(color, for: .normal)
    }
    
}
