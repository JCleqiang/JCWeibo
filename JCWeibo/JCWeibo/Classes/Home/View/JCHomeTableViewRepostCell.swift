//
//  JCHomeTableViewRepostCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeTableViewRepostCell: JCHomeTableViewCell {

    /// 视图模型
    // 注意: 子类重写父类的属性, 不会覆盖父类的操作
    override var statusViewModel: JCStatusViewModel? {
        didSet{
            
            // 1.设置转发正文
            let name = statusViewModel?.statusModel.retweeted_status?.userModel?.screen_name ?? ""
            let text = statusViewModel?.statusModel.retweeted_status?.text ?? ""
            forwradTextLabel.text  = "@" + name + ": " + text
            
//            // 更新配图布局
            collectionView.snp.updateConstraints { (make) -> Void in
                let offsetY = ((statusViewModel?.thumbnail_urls!.count)! > 0) ? kHomeCellMargin : 0
                make.top.equalTo(forwradTextLabel.snp.bottom).offset(offsetY)
            }
        } 
    }
    
    // MAKR: - 懒加载
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        return view
    }()
    lazy var forwradTextLabel = UILabel(text: "fjdsklfjhkldshfjkdshfjkdshjkfjdskfjsdk", color: UIColor.darkGray, screenInset: 10)
    
    
    override func setupUI() {
        super.setupUI()
        
        // 1.添加子控件
        contentView.insertSubview(coverView, belowSubview: collectionView)
        contentView.insertSubview(forwradTextLabel, aboveSubview: coverView)
        
        // 2.布局子控件
        coverView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentTextLabel.snp.bottom).offset(10)
            make.bottom.equalTo(collectionView.snp.bottom).offset(10)
        }
        
        forwradTextLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(coverView.snp.left).offset(kHomeCellMargin)
            make.top.equalTo(coverView.snp.top).offset(kHomeCellMargin)
        }
        
        collectionView.snp.removeConstraints()
        collectionView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(forwradTextLabel.snp.left)
            make.top.equalTo(forwradTextLabel.snp.bottom).offset(kHomeCellMargin)
            make.width.equalTo(0)
            make.height.equalTo(0)
        }
    }

    
}

extension JCHomeTableViewRepostCell {
    }
