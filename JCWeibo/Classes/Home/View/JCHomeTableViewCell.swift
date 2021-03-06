//
//  JCHomeTableViewCell.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/1.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SDWebImage
import YYText

protocol JCHomeTableViewCellDelegate {
    func highlightDidClik(content: String)
}

class JCHomeTableViewCell: UITableViewCell {
    var myDelegate: JCHomeTableViewCellDelegate?
    
    var statusViewModel: JCStatusViewModel? {
        didSet {
            // 头部
            cellTopView.statusViewModel = statusViewModel
            
            // 设置正文
            contentTextLabel.text = statusViewModel?.statusModel.text
            
            // 转成可变属性字符串
            let dict: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let mAttributedString: NSMutableAttributedString = NSMutableAttributedString.init()
            mAttributedString.append(NSAttributedString.init(string: statusViewModel?.statusModel.text ?? "", attributes: dict))
            
            let regulaStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
            let regex = try? NSRegularExpression.init(pattern: regulaStr, options: NSRegularExpression.Options.caseInsensitive)
            if regex != nil {
                let allMatches: [NSTextCheckingResult] = (regex?.matches(in: statusViewModel?.statusModel.text ?? "",
                                                                         options: NSRegularExpression.MatchingOptions.reportCompletion,
                                                                         range: NSRange.init(location: 0, length: statusViewModel?.statusModel.text?.count ?? 0)))!
                for match in allMatches {
                    let tmp: String = statusViewModel?.statusModel.text ?? ""
                    let substrinsgForMatch2: String = (tmp as NSString).substring(with: match.range)
                    let one: NSMutableAttributedString = NSMutableAttributedString.init(string: substrinsgForMatch2)
                    one.yy_font = UIFont.systemFont(ofSize: 16)
                    one.yy_color = UIColor.systemBlue
                    
                    let highlight = YYTextHighlight.init()
                    one.yy_setTextHighlight(highlight, range: one.yy_rangeOfAll())
                    
                    mAttributedString.replaceCharacters(in: match.range, with: one)
                }
            }
            
            let regulaStr2 = "#([^#]{1,40})#"
            let regex2 = try? NSRegularExpression.init(pattern: regulaStr2, options: NSRegularExpression.Options.caseInsensitive)
            if regex2 != nil {
                let allMatches: [NSTextCheckingResult] = (regex2?.matches(in: statusViewModel?.statusModel.text ?? "",
                                                                         options: NSRegularExpression.MatchingOptions.reportCompletion,
                                                                         range: NSRange.init(location: 0, length: statusViewModel?.statusModel.text?.count ?? 0)))!
                for match in allMatches {
                    let tmp: String = statusViewModel?.statusModel.text ?? ""
                    let substrinsgForMatch2: String = (tmp as NSString).substring(with: match.range)
                    let one: NSMutableAttributedString = NSMutableAttributedString.init(string: substrinsgForMatch2)
                    one.yy_font = UIFont.systemFont(ofSize: 16)
                    one.yy_color = UIColor.systemRed
                    
                    let highlight = YYTextHighlight.init()
                    one.yy_setTextHighlight(highlight, range: one.yy_rangeOfAll())
                    
                    mAttributedString.replaceCharacters(in: match.range, with: one)
                }
            }
             
            contentTextLabel.attributedText = mAttributedString
            
            // 配图
            collectionView.viewModel = statusViewModel
            
            let (clvSize, _) = collectionView.calculateSize()
            // 3.2设置容器尺寸
            collectionView.snp.updateConstraints { (make) -> Void in
                make.width.equalTo(clvSize.width)
                make.height.equalTo(clvSize.height)
            }
            
            let retweetTitle: String = (statusViewModel?.statusModel.reposts_count)! == 0 ? "转发": (statusViewModel?.statusModel.reposts_count.description)!
            retweetButton.setTitle(retweetTitle, for: .normal)
            
            let commentTitle: String = (statusViewModel?.statusModel.comments_count)! == 0 ? "评论": (statusViewModel?.statusModel.comments_count.description)!
            commentButton.setTitle(commentTitle, for: .normal)
            
            let unlikeTitle: String = (statusViewModel?.statusModel.attitudes_count)! == 0 ? "赞": (statusViewModel?.statusModel.attitudes_count.description)!
            unlikeButton.setTitle(unlikeTitle, for: .normal)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.statusViewModel = viewModel
        
        layoutIfNeeded()
        
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
            make.top.left.equalTo(contentView)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(66)
        }
        
        // 2.7正文
        contentTextLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(cellTopView.snp.left).offset(10)
            make.top.equalTo(cellTopView.snp.bottom)
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
            make.bottom.equalTo(bottomView.snp.bottom).offset(-8)
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
    
    // MAKR: - 外部控制方法
    class func identiferWithViewModel(viewModel: JCStatusViewModel) -> String {
        return (viewModel.statusModel.retweeted_status != nil) ? JCHomeTableViewRepostCell.identifier() : JCHomeTableViewNormalCell.identifier()
    }

    /// 头部
    private lazy var cellTopView: JCHomeCellTopView = JCHomeCellTopView()
    /// 正文
    lazy var contentTextLabel: YYLabel = {
        let lb = YYLabel()
        lb.textColor = UIColor.darkGray 
        lb.numberOfLines = 0
        lb.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * 10
        lb.font = UIFont.systemFont(ofSize: 16) 
        // 监听URL点击
//        lb.urlLinkTapHandler =  { label, url, range in
//            JCLog(message: "URL \(url) tapped")
//            if (self.myDelegate != nil) {
//                self.myDelegate!.highlightDidClik(content: url)
//            }
//        }
    
        return lb
    }()

    /// 配图
    lazy var collectionView: JCHomeCellPictureView = {
        let clv = JCHomeCellPictureView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        clv.register(JCHomePictureCell.self, forCellWithReuseIdentifier: JCHomePictureCell.identifier())
        clv.backgroundColor = UIColor.clear
        return clv
    }()

    /// 底部工具条
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1.0)
        return view
    }()
    
    /// 转发按钮
    private lazy var retweetButton = UIButton(title: "转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
    /// 评论按钮
    private lazy var commentButton = UIButton(title: "评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
    /// 赞按钮
    private lazy var unlikeButton = UIButton(title: "赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background", color: nil, font: nil)
}
