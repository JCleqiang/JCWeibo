//
//  JLPopMenuController.h
//  NSManagement
//
//  Created by jinglian on 16/12/4.
//  Copyright © 2016年 NSManagement. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellSeletedBlock)(NSIndexPath *indexPath);

@interface JLPopMenuController : UIViewController
 
/** <#属性#> */
@property (nonatomic, copy) CellSeletedBlock cellSeletedBlock;

- (instancetype)initWithMenuArray:(NSArray *)menuArray;

@end
