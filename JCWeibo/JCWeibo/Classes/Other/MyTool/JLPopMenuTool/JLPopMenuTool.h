//
//  JLPopMenuTool.h
//  DoctorAndE
//
//  Created by jinglian on 16/4/6.
//  Copyright © 2016年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLPopMenuTool;

@protocol JLPopMenuToolDelegate <NSObject>

@optional
- (void)popMenuTool:(JLPopMenuTool *)popMenuTool didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface JLPopMenuTool : UIView

/** 菜单上的view */
@property (nonatomic, strong) UIView *contenView;
/** 菜单上的控制器 */
@property (nonatomic, strong) UIViewController *contentController;

+ (instancetype)popMenuTool;

/** <#属性#> */
@property (nonatomic, assign) id<JLPopMenuToolDelegate> delegate;

/** 如果箭头位置不对 就用这个属性微调 */
@property (nonatomic, assign) CGPoint offset;

/** <#属性#> */
@property (nonatomic, strong) NSArray *menuArray;


/**
 *  显示菜单
 *
 *  @param fromView 菜单显示在哪个view的右下边
 */
- (void)showFromView:(UIView *)fromView;

/**
 *  隐藏菜单
 */
- (void)dissmissMenu;
@end
