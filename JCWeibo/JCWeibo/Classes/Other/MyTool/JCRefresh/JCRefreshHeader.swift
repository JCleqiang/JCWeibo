//
//  JCRefreshHeader.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCRefreshHeader: MJRefreshNormalHeader {

    override func prepare() {
        super.prepare()
        
        isAutomaticallyChangeAlpha = true
        
        lastUpdatedTimeLabel.isHidden = true;
        
        stateLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        setTitle("下拉刷新", for: .idle)
        setTitle("释放更新", for: .pulling)
        setTitle("加载中...", for: .refreshing)
    }

}
