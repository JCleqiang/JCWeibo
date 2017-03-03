//
//  KLPhotoBrowserCell.m
//  WisdomFamilyDoctor
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import "KLPhotoBrowserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define NSWeakSelf __weak typeof(self) weakSelf = self;
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)  // 获取屏幕宽度
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@interface KLPhotoBrowserCell () <UIScrollViewDelegate>
/** <#Description#> */
@property (nonatomic, strong) UIScrollView *scrollView;

/** <#属性#> */
@property (nonatomic, strong) UIActivityIndicatorView *actIndicaView;
@end

@implementation KLPhotoBrowserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.iconImageView];
    [self.contentView addSubview:self.actIndicaView];
    
    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    [self reset];

    UIImage *placeHolder = [UIImage imageNamed:@"ic_common_big_errorPic"];
    
    NSWeakSelf;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL fileURLWithPath:imageUrl]]) { // 如果本地图片存在，就从本地获取图片
        [self.iconImageView sd_setImageWithURL:[NSURL fileURLWithPath:imageUrl] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [weakSelf calculateImageSize:image error:error];
        }];
    }
    else {
        [self.actIndicaView startAnimating];
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [weakSelf calculateImageSize:image error:error];
         
            
            [weakSelf.actIndicaView stopAnimating];
        }];
    }
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        [self calculateImageSize:image error:error];
//    }];
}

- (void)calculateImageSize:(UIImage *)image error:(NSError *)error {
    // 1.按照宽高比缩放图片
    CGFloat scale  = image.size.height / image.size.width;
    CGFloat height = scale * SCREEN_WIDTH;
    
    if (image == nil || error) {
        height = SCREEN_HEIGHT;
    }
    
    self.iconImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
    // 2.判断是长图还是短图
    if (height < SCREEN_HEIGHT) {
        // 短图, 需要居中
        //1.1计算偏移位
        CGFloat offsetY = (SCREEN_HEIGHT - height) * 0.5;
        
        // 1.2设置偏移位
        self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, offsetY, 0);
    }
    else {
        // 长图, 不需要居中
        self.scrollView.contentSize = self.iconImageView.frame.size;
    }

}

- (void)reset {
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.iconImageView.transform = CGAffineTransformIdentity;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _iconImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // scrollView被缩放的view, 它的frame和bounds是有一定的区别的
    // bounds是的值是固定的, 而frame的值是变化的
    // 所以被缩放的控件的frame就是scrollView的contentSize
    // 也就是说frame的值和contentSize一样的
    CGFloat offsetY = (SCREEN_HEIGHT - _iconImageView.frame.size.height) * 0.5;
    // 注意: 当偏移位小于0时会导致图片无法拖拽查看完整图片, 所以当偏移位小于0时需要复位为0
    offsetY = (offsetY < 0) ? 0 : offsetY;
    CGFloat offsetX = (SCREEN_WIDTH - _iconImageView.frame.size.width) * 0.5;
    offsetX = (offsetX < 0) ? 0 : offsetX;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetY);
}

- (void)imageDidClick {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick)];
        [scrollView addGestureRecognizer:tap];

    }
    return _scrollView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _iconImageView = iconImageView;
        iconImageView.userInteractionEnabled = YES;
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick)];
        [iconImageView addGestureRecognizer:tap];
    }
    return _iconImageView;
}

- (UIActivityIndicatorView *)actIndicaView {
    if (!_actIndicaView) {
        UIActivityIndicatorView *actIndicaView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _actIndicaView = actIndicaView;
        actIndicaView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    }
    return _actIndicaView;
}
@end
