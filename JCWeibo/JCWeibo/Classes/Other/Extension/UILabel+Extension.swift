//
//  UILabel+Extension.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, color: UIColor = UIColor.lightGray, screenInset: CGFloat = 0) {
        
        self.init()
        self.text = text
        textColor = color
        numberOfLines = 0
        
        if screenInset != 0 {
            textAlignment = .left
            // 约束Label最大的宽度
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
        }else {
            textAlignment = .center
        }
    }
}

