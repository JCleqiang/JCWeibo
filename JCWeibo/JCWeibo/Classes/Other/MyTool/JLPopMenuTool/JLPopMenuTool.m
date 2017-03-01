//
//  JLPopMenuTool.m
//  DoctorAndE
//
//  Created by jinglian on 16/4/6.
//  Copyright © 2016年 skytoup. All rights reserved.
//

#import "JLPopMenuTool.h"
#import "JLPopMenuTool.h"
#import "JLPopMenuController.h"
#import "UIView+Frame.h"

#define NSWeakSelf __weak typeof(self) weakSelf = self;

@interface JLPopMenuTool ()
/** 容器视图 */
@property (nonatomic, weak) UIImageView *backgroundView;
/** <#属性#> */
@property (nonatomic, assign) CGFloat fromViewCenterY;
@end

@implementation JLPopMenuTool
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

+ (instancetype)popMenuTool {
    return  [[self alloc] init];
}

- (void)showFromView:(UIView *)fromView {
    // 1.设置遮盖版
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    
    // 调整容器视图的位置
    // newFrame:fromView在window下的fram
    CGRect newFrame = [fromView.superview convertRect:fromView.frame toView:window];
    
    self.fromViewCenterY = newFrame.origin.y;
    
    // 设置backgroundView在fromView的右下方
    self.backgroundView.jc_right = CGRectGetMaxX(newFrame) + _offset.x;
    
    self.backgroundView.jc_y = CGRectGetMaxY(newFrame) + _offset.y;
    self.backgroundView.image = [UIImage imageNamed:@"popover_background.png"];
}

- (void)dissmissMenu {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dissmissMenu];
}

- (void)setContenView:(UIView *)contenView {
    _contenView = contenView;
    
    // 调整内容的位置
    contenView.jc_x = 15;
    contenView.jc_y = 15;
    
    // 设置backgroundView的高度和宽度
    self.backgroundView.jc_width = CGRectGetMaxX(contenView.frame) + 15;
    self.backgroundView.jc_height = CGRectGetMaxY(contenView.frame) + 15;
    
    [self.backgroundView addSubview:contenView];
}

- (void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    self.contenView = contentController.view;
}

- (void)setMenuArray:(NSArray *)menuArray {
    _menuArray = menuArray;

    JLPopMenuController *popMenuController = [[JLPopMenuController alloc] initWithMenuArray:menuArray];
    
    NSWeakSelf;
    [popMenuController setCellSeletedBlock:^(NSIndexPath *indexPath) {
        if ([weakSelf.delegate respondsToSelector:@selector(popMenuTool:didSelectRowAtIndexPath:)]) {
            [weakSelf.delegate popMenuTool:weakSelf didSelectRowAtIndexPath:indexPath];
            
            [weakSelf removeFromSuperview];
        }
    }];
    
    self.contentController = popMenuController;
}

#pragma mark - Lazy
- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.alpha = 1.0;
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
    }
    
    return _backgroundView;
}

@end
