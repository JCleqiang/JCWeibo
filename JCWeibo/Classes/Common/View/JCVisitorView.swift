//
//  JCVisitorView.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SnapKit

class JCVisitorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    // Swift这样做的目的是为了让我们更简单高效开发
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        backgroundColor = UIColor(white: 237.0/255.0, alpha: 1.0)
        
        addSubview(visitorImageView)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        visitorImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(150)
            make.center.equalTo(self)
        }
        
        let middle = UIScreen.main.bounds.size.width * 0.5;
        
        loginBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(visitorImageView.snp.bottom).offset(35)
            make.left.equalTo(middle - 130)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.width.equalTo(loginBtn.snp.width)
            make.height.equalTo(loginBtn.snp.height)
            make.top.equalTo(loginBtn.snp.top)
            make.left.equalTo(middle + 30)
        }
    }
    
    // MARK: Lazy
    private lazy var visitorImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    lazy var loginBtn = UIButton.init(title: "登录", backgroundImageName: "common_button_white_disable", color: UIColor.lightGray)
    lazy var registerBtn = UIButton.init(title: "注册", backgroundImageName: "common_button_white_disable", color: UIColor.orange)
}
