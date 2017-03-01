//
//  UIView+Frame.m
//  WisdomFamilyDoctor
//
//  Created by jinglian on 16/6/18.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setJc_width:(CGFloat)jc_width {
    CGRect frame = self.frame;
    frame.size.width = jc_width;
    self.frame = frame;
}


- (CGFloat)jc_width {
    return self.frame.size.width;
}

- (void)setJc_height:(CGFloat)jc_height {
    CGRect frame = self.frame;
    frame.size.height = jc_height;
    self.frame = frame;
}

- (CGFloat)jc_height {
    return self.frame.size.height;
}

- (void)setJc_centerX:(CGFloat)jc_centerX {
    CGPoint center = self.center;
    center.x = jc_centerX;
    self.center = center;
}

- (CGFloat)jc_centerX {
    return self.center.x;
}

- (void)setJc_centerY:(CGFloat)jc_centerY {
    CGPoint center = self.center;
    center.y = jc_centerY;
    self.center = center;
}
- (CGFloat)jc_centerY {
    return self.center.y;
}

- (void)setJc_x:(CGFloat)jc_x {
    CGRect frame = self.frame;
    frame.origin.x = jc_x;
    self.frame = frame;
    
}
- (CGFloat)jc_x {
    return self.frame.origin.x;
}

- (void)setJc_y:(CGFloat)jc_y {
    CGRect frame = self.frame;
    frame.origin.y = jc_y;
    self.frame = frame;
    
}

- (CGFloat)jc_y {
    return self.frame.origin.y;
}

- (void)setJc_left:(CGFloat)jc_left {
    self.jc_x = jc_left;
}

- (CGFloat)jc_left {
    return self.jc_x;
}

- (void)setJc_top:(CGFloat)jc_top {
    self.jc_y = jc_top;
}

- (CGFloat)jc_top {
    return self.jc_y;
}

- (void)setJc_right:(CGFloat)jc_right {
    CGRect frame = self.frame;
    frame.origin.x = jc_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)jc_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setJc_bottom:(CGFloat)jc_bottom {
    CGRect frame = self.frame;
    frame.origin.y = jc_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)jc_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)jc_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (id)jc_subviewWithTag:(NSInteger)tag {
    
    for(UIView *view in [self subviews]){
        if(view.tag == tag){
            return view;
        }
    }
    return nil;
}

- (BOOL)jc_containterSubView:(UIView *)subView {
    for (int i = 0; i < self.subviews.count; i++) {
        if ([self.subviews[i] isEqual:subView]) {
            return YES;
        }
    }
    
    return NO;
}
@end
