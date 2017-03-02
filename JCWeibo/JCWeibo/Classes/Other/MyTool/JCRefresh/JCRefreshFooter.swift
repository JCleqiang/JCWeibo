//
//  JCRefreshFooter.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCRefreshFooter: MJRefreshAutoNormalFooter {

    override func prepare() {
        super.prepare()
        
        // 底部刷新控件露出0.1部分就自动刷新
        triggerAutomaticallyRefreshPercent = 0.1;
        isAutomaticallyHidden = true;
        
        stateLabel.font = UIFont.systemFont(ofSize: 13.0)

        
        isAutomaticallyChangeAlpha = true 
    }

}
