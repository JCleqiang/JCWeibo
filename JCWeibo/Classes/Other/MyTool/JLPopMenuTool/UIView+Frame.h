//
//  UIView+Frame.h
//  WisdomFamilyDoctor
//
//  Created by jinglian on 16/6/18.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>  
#import <Foundation/Foundation.h>

@interface UIView (Frame)
/** 控件 宽度 */
@property (nonatomic, assign) CGFloat jc_width;

/** 控件 高度 */
@property (nonatomic, assign) CGFloat jc_height;

/** 控件 中点的x坐标值 */
@property (nonatomic, assign) CGFloat jc_centerX;

/** 控件 中点的y坐标值 */
@property (nonatomic, assign) CGFloat jc_centerY;

/** 控件 x坐标值 */
@property (nonatomic, assign) CGFloat jc_x;

/** 控件 y坐标值 */
@property (nonatomic, assign) CGFloat jc_y;

/** 控件最左边那根线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat jc_left;

/** 控件最右边那根线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat jc_right;

/** 控件最顶部那根线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat jc_top;

/** 控件最底部那根线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat jc_bottom;

/**
 *  移除所有字控件
 */
- (void)jc_removeAllSubviews;

- (id)jc_subviewWithTag:(NSInteger)tag;

/**
 *  是否包含某个子控制器
 */
- (BOOL)jc_containterSubView:(UIView *)subView;
@end
