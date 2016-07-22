//
//  SQPodsTableViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/6.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQPodsTableViewController.h"

@interface SQPodsTableViewController ()

@property (nonatomic, strong) NSArray *groupofPods;

@end

@implementation SQPodsTableViewController
#pragma mark - 懒加载
- (NSArray *)groupofPods{
    if (_groupofPods == nil) {
        NSArray *array = @[
                           @{
                               @"name": @"Realm",
                               @"URLString": @"https://github.com/realm/realm-cocoa"
                               },
                           @{
                               @"name": @"Masonry",
                               @"URLString": @"https://github.com/SnapKit/Masonry"
                               },
                           @{
                               @"name": @"pop",
                               @"URLString": @"https://github.com/facebook/pop"
                               },
                           @{
                               @"name": @"JazzHands",
                               @"URLString": @"https://github.com/IFTTT/JazzHands"
                               },
                           @{
                               @"name": @"CocoaLumberjack",
                               @"URLString": @"https://github.com/CocoaLumberjack/CocoaLumberjack"
                               },
                           @{
                               @"name": @"PKRevealController",
                               @"URLString": @"https://github.com/pkluz/PKRevealController"
                               },
                           @{
                               @"name": @"DZNEmptyDataSet",
                               @"URLString": @"https://github.com/dzenbot/DZNEmptyDataSet"
                               },
                           @{
                               @"name":@"JBChartView",
                               @"URLString":@"https://github.com/Jawbone/JBChartView"
                               },
                           @{
                               @"name":@"XYPieChart",
                               @"URLString":@"https://github.com/xyfeng/XYPieChart"
                               },
                           @{
                               @"name": @"STPopup",
                               @"URLString": @"https://github.com/kevin0571/STPopup"
                               },
                           @{
                               @"name": @"IAPHelper",
                               @"URLString": @"https://github.com/saturngod/IAPHelper"
                               },
        ];
        _groupofPods = array;
    }
    return _groupofPods;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];

    self.tableView.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger number = 0;
    
    if (section == 0) {
        number = 1;
    }else if(section == 1){
        number = self.groupofPods.count;
    }
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOf10KHOURSTableViewCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kIdentifierOf10KHOURSTableViewCell];
        }
        
        cell.textLabel.text = @"Four on GitHub";
        cell.textLabel.font = kSQDefaultFontBoldWith(24);
        cell.textLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        cell.detailTextLabel.text = @"Welcome contributions!";
        cell.detailTextLabel.font = kSQDefaultTertiaryFont;
        cell.detailTextLabel.textColor = kSQColorDefaultSecondaryTextWhiteColor;
        
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfPodsTableViewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifierOfPodsTableViewCell];
        }
        NSDictionary *dict = self.groupofPods[indexPath.row];
        cell.textLabel.text = dict[@"name"];
        cell.textLabel.font = kSQDefaultFontRegularWith(18);
        cell.textLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        
    }
    cell.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = kPodsManiCellHeight;
    }else if(indexPath.section == 1){
        height = kPodsDefaultCellHeight;
    }
    return height;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *urlString = @"https://github.com/SketchK/Four";
        NSURL *url = [NSURL URLWithString:urlString];
        SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:vc animated:YES completion:nil];
    }else if(indexPath.section == 1){
        NSDictionary *dict = self.groupofPods[indexPath.row];
        NSURL *url = [NSURL URLWithString:dict[@"URLString"]];
        SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:vc animated:YES completion:nil];
    }
}


@end
