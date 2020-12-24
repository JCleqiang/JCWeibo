//
//  JLPopMenuCell.h
//  NSManagement
//
//  Created by jinglian on 16/12/4.
//  Copyright © 2016年 NSManagement. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kPopMenuCellId = @"__popMenuCellId__";

@interface JLPopMenuCell : UITableViewCell

/** 属性 */
@property (nonatomic, copy) NSString *menuTitle;

@end
