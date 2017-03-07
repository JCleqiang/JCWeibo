//
//  NSFilterNavBarButton.m
//  NSManagement
//
//  Created by jinglian on 16/11/5.
//  Copyright © 2016年 NSManagement. All rights reserved.
//

#import "NSFilterNavBarButton.h"
#import "UIView+Frame.h"
#import "UIButton+FillColor.h"

@implementation NSFilterNavBarButton

+ (instancetype)filterNavBarButton {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    [self kl_setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self setImage:[UIImage imageNamed:@"ic_arrows_gray_back.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"ic_arrows_gray_come.png"] forState:UIControlStateSelected];
    
    self.layer.cornerRadius = 3;
//    self.layer.masksToBounds = YES;
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    
    [self setTitle:navTitle forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = CGPointMake(self.jc_width * 0.5, self.jc_height * 0.5);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    [self sizeToFit];
    
    self.imageView.jc_width = 8;
    self.imageView.jc_height = self.imageView.jc_width;
    self.imageView.jc_top = self.titleLabel.jc_bottom;
    self.imageView.jc_centerX = self.jc_width * 0.5;
}

@end
