//
//  SQAboutUsTableViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/6.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAboutUsTableViewController.h"

@interface SQAboutUsTableViewController ()

@property (nonatomic, strong) SQAboutUsTableViewHeader *headerView;

@end

@implementation SQAboutUsTableViewController
#pragma mark - 懒加载
- (SQAboutUsTableViewHeader *)headerView{
    if (_headerView == nil) {
        CGRect rect = CGRectMake(0, 0, kScreenWidht, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 2 * kAboutUsCellHeight);
        _headerView = [[SQAboutUsTableViewHeader alloc] initWithFrame:rect];
    }
    return _headerView;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifierOfAboutUsTableViewCell];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = kAboutUsCellHeight;
    self.tableView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kAboutUsCellNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfAboutUsTableViewCell];
    cell.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    cell.textLabel.font = kSQDefaultFontRegularWith(kAboutUsCellFontSize);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Pods helps FOUR";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"Developer Info";
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SQPodsTableViewController *podsVC = [[SQPodsTableViewController alloc ] init];
        [self.navigationController pushViewController:podsVC animated:YES];
    }else if(indexPath.row == 1){
        SQDeveloperTableViewController *devVC = [[SQDeveloperTableViewController alloc] init];
        [self.navigationController pushViewController:devVC animated:YES];
    }
}

@end
