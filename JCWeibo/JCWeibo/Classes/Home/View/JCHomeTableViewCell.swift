//
//  JCHomeTableViewCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SDWebImage

let kHomeCellId = "__homeCellId__"

class JCHomeTableViewCell: UITableViewCell {
    
    var statusViewModel: JCStatusViewModel? {
        didSet {
            // 设置数据
            // 1.设置头像
            iconImageView.sd_setImage(with: statusViewModel?.AvatarURL as URL!)
            // 2.设置认证图标
            verifiedImageView.image = statusViewModel?.verifiedImage
            // 3.设置昵称
            nameLabel.text = statusViewModel?.statusModel.userModel?.screen_name
            // 4.设置会员图标
            vipImageView.image = statusViewModel?.vipImage
            nameLabel.textColor = UIColor.darkGray
            if statusViewModel?.vipImage != nil {
                nameLabel.textColor = UIColor.orange
            }
            // 5.设置时间
            timeLabel.text = statusViewModel?.timeStr
            // 6.设置来源
            sourceLabel.text = statusViewModel?.sourceStr
            // 7.设置正文
            contentTextLabel.text = statusViewModel?.statusModel.text
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
    
    func setupUI() {
        // 1.添加子控件
        contentView.addSubview(iconImageView)
        contentView.addSubview(verifiedImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(vipImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(bottomView)
        bottomView.addSubview(retweetButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(unlikeButton)
        
        // 2.布局子控件
        // 2.1布局头像
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        iconImageView.layer.cornerRadius = 25
        iconImageView.layer.masksToBounds = true
        
        // 2.2布局认证图标
        verifiedImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(iconImageView.snp.right)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        // 2.3布局昵称
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(10)
        }
        
        // 2.4布局会员图标
        vipImageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(nameLabel.snp.right).offset(10)
        }
        
        // 2.5时间
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        // 2.6来源
        sourceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(timeLabel.snp.top)
            make.left.equalTo(timeLabel.snp.right).offset(10)
        }
        
        // 2.7正文
        contentTextLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp.left)
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
        }
        
        // 2.8底部工具条
        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
            make.top.equalTo(contentTextLabel.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom)
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

    // MAKR: - 懒加载
    /// 头像
    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    /// 认证图标
    private lazy var verifiedImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    /// 昵称
    private lazy var nameLabel = UILabel(text: "", color: UIColor.lightGray, screenInset: 0)
    /// 会员图标
    private lazy var vipImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    /// 时间
    private lazy var timeLabel = UILabel(text: "", color: UIColor.orange, screenInset: 0)
    /// 来源
    private lazy var sourceLabel = UILabel(text: "", color: UIColor.lightGray, screenInset: 0)
    /// 正文
    private lazy var contentTextLabel =  UILabel(text: "fhdjksfhjksdhfjkdshfjkdshjkfhdsjkfhdsjkfdsjklfjdsklfjdsklfjklsdfjkldsjflkdsjfkldsjfkldsjklfjdsklfjdskljfkldsjfncoiewnijewnifniweuniwe", color: UIColor.darkGray, screenInset: 10)
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
