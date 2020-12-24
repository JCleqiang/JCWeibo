//
//  JCHomeCellTopView.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit

class JCHomeCellTopView: UIView {
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
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(iconImageView)
        addSubview(verifiedImageView)
        addSubview(nameLabel)
        addSubview(vipImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        // 2.1布局头像
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        iconImageView.layer.cornerRadius = 22
        iconImageView.layer.masksToBounds = true
        
        // 2.2布局认证图标
        verifiedImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(iconImageView.snp.right)
            make.bottom.equalTo(iconImageView.snp.bottom)
        }
        
        // 2.3布局昵称
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp.top).offset(3)
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
            make.bottom.equalTo(iconImageView.snp.bottom).offset(-3)
        }
        
        // 2.6来源
        sourceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(timeLabel.snp.top)
            make.left.equalTo(timeLabel.snp.right).offset(10)
        }
    }
    
    // MAKR: - 懒加载
    /// 头像
    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    /// 认证图标
    private lazy var verifiedImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    /// 昵称
    private lazy var nameLabel = UILabel(text: "", fontSize:15, color: UIColor.darkGray, screenInset: 0)
    /// 会员图标
    private lazy var vipImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    /// 时间
    private lazy var timeLabel = UILabel(text: "", fontSize:12, color: UIColor.orange, screenInset: 0)
    /// 来源
    private lazy var sourceLabel = UILabel(text: "", fontSize:12, color: UIColor.lightGray, screenInset: 0)
}
