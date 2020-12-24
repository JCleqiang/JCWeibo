//
//  JCHomeTableViewNormalCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeTableViewNormalCell: JCHomeTableViewCell {
    /// 视图模型
    override var statusViewModel: JCStatusViewModel? {
        didSet{
            // 更新配图布局
            collectionView.snp.updateConstraints { (make) -> Void in
                let offsetY = ((statusViewModel?.thumbnail_urls?.count)! > 0) ? kHomeCellMargin : 0
                make.top.equalTo(contentTextLabel.snp.bottom).offset(offsetY)
            }
        }
    }
}
