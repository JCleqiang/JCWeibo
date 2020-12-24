//
//  JLPopMenuController.m
//  NSManagement
//
//  Created by ; on 16/12/4.
//  Copyright © 2016年 NSManagement. All rights reserved.
//

#import "JLPopMenuController.h"
#import "JLPopMenuCell.h"

@interface JLPopMenuController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_menuArray;
}
/** <#属性#> */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation JLPopMenuController

- (instancetype)initWithMenuArray:(NSArray *)menuArray {
    if (self = [super init]) {
        _menuArray = menuArray;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(0, 0, 90, 44 * _menuArray.count);
    
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JLPopMenuCell class]) bundle:nil] forCellReuseIdentifier:kPopMenuCellId];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JLPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kPopMenuCellId];
    
    cell.menuTitle = _menuArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.cellSeletedBlock) {
        self.cellSeletedBlock(indexPath);
    }
}

@end
