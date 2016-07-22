//
//  SQLeftMenuViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/21.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQLeftMenuViewController.h"

@interface SQLeftMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation SQLeftMenuViewController
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - kSideMenuCellHeight * kLeftSideMenuCellNumber) / 2.0f, self.view.frame.size.width, kSideMenuCellHeight * kLeftSideMenuCellNumber) style:UITableViewStylePlain];
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        //设置代理
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        _tableView = tableView;
    }
    return  _tableView;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kSQColorDefaultNaviBarColor;
    [self.view addSubview:self.tableView];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            SQOverviewTableViewController *vc = [[SQOverviewTableViewController alloc] init];
            [UIViewController pushViewControllerByNavigationVCInRevealVCFront:vc];
            break;
        }
        case 1:{
            SQHistoryViewController *vc = [[SQHistoryViewController alloc] init];
            [UIViewController pushViewControllerByNavigationVCInRevealVCFront:vc];
            break;
        }case 2:{
            SQAnalysisCollectionViewController *vc = [[SQAnalysisCollectionViewController alloc] initWithCollectionViewLayout:[[SQAnalysisCollectionViewFlowLayout alloc] init]];
            [UIViewController pushViewControllerByNavigationVCInRevealVCFront:vc];
            break;
        }
        default:{
            break;
        }
    }
}

#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSideMenuCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return kLeftSideMenuCellNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfLeftMenuTableViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifierOfLeftMenuTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = kSQDefaultSecondaryBoldFont ;
        cell.textLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    NSArray *titles = @[@"OVERVIEW",@"HISTORY", @"ANALYSIS"];
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}


@end
