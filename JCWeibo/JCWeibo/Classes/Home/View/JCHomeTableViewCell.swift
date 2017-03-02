//
//  JCHomeTableViewCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SDWebImage 

class JCHomeTableViewCell: UITableViewCell {
    var statusViewModel: JCStatusViewModel? {
        didSet {
            // 头部
            cellTopView.statusViewModel = statusViewModel
            // 设置正文
            contentTextLabel.text = statusViewModel?.statusModel.text
            
            // 配图
            collectionView.viewModel = statusViewModel
            
            let (clvSize, _) = collectionView.calculateSize()
            // 3.2设置容器尺寸
            collectionView.snp.updateConstraints { (make) -> Void in
                make.width.equalTo(clvSize.width)
                make.height.equalTo(clvSize.height)
            }
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 初始化
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - 外部控制方法
    class func identifier() -> String {
        return NSStringFromClass(self)
    }
    
    /**
     计算行高
     */
    func rowHeight(viewModel: JCStatusViewModel) -> CGFloat {
        // 1.设置数据
        self.statusViewModel = viewModel
        
        // 2.更新布局
        layoutIfNeeded()
        
        // 3.返回行高
        return bottomView.frame.maxY 
    }
    
    func setupUI() {
        // 1.添加子控件
        contentView.addSubview(cellTopView)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(retweetButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(unlikeButton)
        
        // 2.布局子控件
        cellTopView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(66)
        }
        
        // 2.7正文
        contentTextLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(cellTopView.snp.left).offset(kHomeCellMargin)
            make.top.equalTo(cellTopView.snp.bottom).offset(kHomeCellMargin)
        }
        
        // 配图
        collectionView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp.left).offset(kHomeCellMargin)
            make.top.equalTo(contentTextLabel.snp.bottom).offset(kHomeCellMargin)
            make.width.equalTo(0)
            make.height.equalTo(0)
        }
        
        // 2.8底部工具条
        bottomView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(44)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
        }
        
        // 2.9转发
        retweetButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(bottomView.snp.left)
            make.top.equalTo(bottomView.snp.top)
            make.bottom.equalTo(bottomView.snp.bottom)
        }
        // 2.10评论
        commentButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(retweetButton.snp.right)
            make.top.equalTo(retweetButton.snp.top)
            make.bottom.equalTo(retweetButton.snp.bottom)
            make.width.equalTo(retweetButton.snp.width)
        }
        // 2.11赞
        unlikeButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(commentButton.snp.right)
            make.top.equalTo(commentButton.snp.top)
            make.bottom.equalTo(commentButton.snp.bottom)
            make.width.equalTo(commentButton.snp.width)
            make.right.equalTo(bottomView.snp.right)
        }
    }
 
    /// 头部
    private lazy var cellTopView: JCHomeCellTopView = JCHomeCellTopView()
    /// 正文
    private lazy var contentTextLabel =  UILabel(text: "fhdjksfhjksdhfjkdshfjkdshjkfhdsjkfhdsjkfdsjklfjdsklfjdsklfjklsdfjkldsjflkdsjfkldsjfkldsjklfjdsklfjdskljfkldsjfncoiewnijewnifniweuniwe", color: UIColor.darkGray, screenInset: 10)
    /// 配图
    private lazy var collectionView: JCHomeCellPictureView = {
        let clv = JCHomeCellPictureView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        clv.register(JCHomePictureCell.self, forCellWithReuseIdentifier: JCHomePictureCell.identifier())
        clv.backgroundColor = UIColor.clear
        return clv
    }()

    /// 底部工具条
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    /// 转发按钮
    private lazy var retweetButton = UIButton(title: "转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
    /// 评论按钮
    private lazy var commentButton = UIButton(title: "评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
    /// 赞按钮
    private lazy var unlikeButton = UIButton(title: "赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
}
