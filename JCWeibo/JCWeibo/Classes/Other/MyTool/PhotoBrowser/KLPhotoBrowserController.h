//
//  KLPhotoBrowserController.h
//  WisdomFamilyDoctor
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLPhotoBrowserController : UIViewController


/**
 <#Description#>

 @param imageMessageArray 图片路径数组
 @param seletedIndex      <#seletedIndex description#>

 @return <#return value description#>
 */
- (instancetype)initWithImageMessageArray:(NSArray <NSString *>*)imageMessageArray seletedIndex:(NSInteger)seletedIndex;

@end
