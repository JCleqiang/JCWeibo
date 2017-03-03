//
//  KLPhotoBrowserController.m
//  WisdomFamilyDoctor
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 kinglian. All rights reserved.
//

#import "KLPhotoBrowserController.h"
#import "KLPhotoBrowserCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define NSWeakSelf __weak typeof(self) weakSelf = self;
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)  // 获取屏幕宽度
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@interface KLPhotoBrowserController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UIActionSheetDelegate> {
    NSArray *_imageMessageArray;
    NSInteger _seletedIndex;
    
    NSIndexPath *_curIndexPath;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomContainterView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end

@implementation KLPhotoBrowserController

- (instancetype)initWithImageMessageArray:(NSArray <NSString *>*)imageMessageArray seletedIndex:(NSInteger)seletedIndex {
    if (self = [super init]) {
        _imageMessageArray = imageMessageArray;
        _seletedIndex = seletedIndex;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomContainterView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.indexLabel.textColor = [UIColor whiteColor];
    
    self.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld", _seletedIndex + 1, _imageMessageArray.count];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KLPhotoBrowserCell class]) bundle:nil] forCellWithReuseIdentifier:PHOTO_BROWSER_CELL_ID];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_imageMessageArray.count >= 2) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_seletedIndex inSection:0];
        NSLog(@"滚动到第%ld张", _seletedIndex);
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    
//    
//}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageMessageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KLPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_BROWSER_CELL_ID forIndexPath:indexPath];
    
    cell.imageUrl = _imageMessageArray[indexPath.item];
    
    _curIndexPath = indexPath;
    
    NSWeakSelf;
    [cell setClickBlock:^() {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
     
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n类名: %@\n方法: %s\n", NSStringFromClass([self class]), __func__);
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isMemberOfClass:[UICollectionView class]]) {
        
        NSInteger index = 0;
        if (scrollView.contentOffset.x >= 0) {
            index = floor(scrollView.contentOffset.x * 1.0 / SCREEN_WIDTH);
        }
        
        self.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld", index + 1, _imageMessageArray.count];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [SVProgressHUD showWithStatus:@"保存中"];
        
        KLPhotoBrowserCell *cell = [self.collectionView cellForItemAtIndexPath:_curIndexPath];

        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib writeImageToSavedPhotosAlbum:cell.iconImageView.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
                return;
            }
            
             [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }];
    }
}

#pragma mark - Action
- (IBAction)saveButtonDidClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"保存到系统相册?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
    [sheet showInView:self.view];
}

 
@end
