//
//  JLPopMenuCell.m
//  NSManagement
//
//  Created by jinglian on 16/12/4.
//  Copyright © 2016年 NSManagement. All rights reserved.
//

#import "JLPopMenuCell.h"

@interface JLPopMenuCell ()
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

@end

@implementation JLPopMenuCell

- (void)awakeFromNib {
    [super awakeFromNib]; 
}

- (void)setMenuTitle:(NSString *)menuTitle {
    _menuTitle = menuTitle;
    
    self.menuLabel.text = menuTitle;
}


@end
