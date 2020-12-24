//
//  JCHomeCellPictureView.swift
//  JCWeibo
//
//  Created by leqiang222 on 2017/3/2.
//  Copyright © 2017年 com.leqiang222. All rights reserved.
//

import UIKit
import SDWebImage

let kHomeCellMargin: CGFloat = 5;

class JCHomeCellPictureView: UICollectionView {

    /// 视图模型
    var viewModel: JCStatusViewModel? {
        didSet{
            let (_, itemSize) = calculateSize()
            // 8.3 设置cell尺寸
            if itemSize != .zero {
                let layout = collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = itemSize
                layout.minimumInteritemSpacing = CGFloat(kHomeCellMargin)
                layout.minimumLineSpacing = CGFloat(kHomeCellMargin)
            }
            
            // 8.4刷新表格
            reloadData()
        }
    }
    
    // MAKR: - 生命周期方法
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - 外部控制方法
    /**
     计算配图容器和cell的宽高
     
     - returns: 第一个是容器的宽高, 第二个是cell的宽高
     */
    func calculateSize() ->(CGSize, CGSize) {
        // 1.取出配图的个数
        let count = viewModel?.thumbnail_urls?.count ?? 0
        var col = 3
        var row = 3
        // cell宽度 = (屏幕宽度 - (列数 + 1) * 间隙) / 列数
        let screenWidth = Int(UIScreen.main.bounds.width)
        let cellWidth = (screenWidth - (col + 1) * (Int)(kHomeCellMargin)) / col
        let cellHeight = cellWidth
        
        // 2.计算容器和cell的尺寸
        if count == 0 {
            return (.zero, .zero)
        }
        
        if count == 1 {
            // 2.1判断是否是一张
            let key = viewModel!.thumbnail_urls!.first!.absoluteString
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: key)
            
            guard let img = image else {
                let size = CGSize(width: cellWidth, height: cellWidth)
                 
                return (size, size)
            }
            
            let width = img.size.width * UIScreen.main.nativeScale
            let height = img.size.height * UIScreen.main.nativeScale
            let size = CGSize(width: width, height: height)
            return (size, size) 
        }
        
        if count == 4 {
            // 2.2判断是否是四张
            row = 2
            col = row
            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
            let width = col * cellWidth + (col - 1) * (Int)(kHomeCellMargin)
            let height = width
            return(CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
        }
        
        // 2.3其它张(九宫格)
        col = 3
        row = (count - 1) / 3 + 1
        // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
        let width = col * cellWidth + (col - 1) * (Int)(kHomeCellMargin)
        let height = row * cellHeight + (row - 1) * (Int)(kHomeCellMargin)
        
        return (CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
    }
}

// MAKR: - 数据源方法
extension JCHomeCellPictureView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnail_urls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JCHomePictureCell.identifier(), for: indexPath as IndexPath) as! JCHomePictureCell
        
        cell.backgroundColor = UIColor.red
        cell.url = viewModel!.thumbnail_urls![indexPath.item]
        
        return cell
    }
}

// MAKR: - 代理方法
extension JCHomeCellPictureView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { 
        // 2.取出当前点击图片的大图URL
        let url = viewModel!.large_urls![indexPath.item] 
        
        SDWebImageManager.shared().downloadImage(with: NSURL(string: url as String) as URL?, options: SDWebImageOptions.retryFailed, progress: { (current, total) in
            //
            }) { (_, _, _, _, _) in
                let userInfo: [String: Any] = ["urls": self.viewModel!.large_urls!, "indexPath": indexPath]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: JCScanBigPicNotification), object: nil, userInfo: userInfo)
        }
    }
}

// MAKR: - 自定义配图Cell
class JCHomePictureCell: UICollectionViewCell {
    var url: NSURL? {
        didSet{
            imageView.sd_setImage(with: url as URL?)
        }
    }
    
    // MAKR: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
    }
    
    // MAKR: - 外部控制方法
    class func identifier() -> String {
        return NSStringFromClass(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - 懒加载
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

}
