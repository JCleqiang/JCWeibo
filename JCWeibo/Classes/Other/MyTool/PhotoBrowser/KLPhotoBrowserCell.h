//
//  KLPhotoBrowserCell.h
//  WisdomFamilyDoctor
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h> 
@class KLPhotoBrowserCell;

static NSString * const PHOTO_BROWSER_CELL_ID = @"__photoBrowserCellId__";

typedef void(^PicDidClickBlock)();

@interface KLPhotoBrowserCell : UICollectionViewCell

/** <#属性#> */
@property (nonatomic, strong) UIImageView *iconImageView;

/** <#属性#> */
@property (nonatomic, copy) NSString *imageUrl;

/** <#属性#> */
@property (nonatomic, copy) PicDidClickBlock clickBlock;

@end
