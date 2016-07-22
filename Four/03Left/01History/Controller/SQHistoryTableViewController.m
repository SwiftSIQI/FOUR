//
//  SQHistoryTableViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHistoryTableViewController.h"

@interface SQHistoryTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) RLMResults<SQTaskDetailsRealmModel *> *groupOfTaskDetailsRealmModel;
@property (nonatomic, strong) SQHistoryTableViewHeader *headerView;

@end

@implementation SQHistoryTableViewController
#pragma mark - 懒加载
- (RLMResults<SQTaskDetailsRealmModel *> *)groupOfTaskDetailsRealmModel{
    if (_groupOfTaskDetailsRealmModel == nil) {
        RLMResults<SQTaskDetailsRealmModel *> *result = [[SQTaskDetailsRealmModel objectsWhere:@"taskColor = %@ AND taskName = %@", self.taskRealmModel.taskColor, self.taskRealmModel.taskName] sortedResultsUsingProperty:@"creatTime" ascending:NO];
        _groupOfTaskDetailsRealmModel = result;
    }
    return _groupOfTaskDetailsRealmModel;
}

- (SQHistoryTableViewHeader *)headerView {
    if (_headerView == nil) {
        SQHistoryTableViewHeader *headerView = [[SQHistoryTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, 95)];
        headerView.taskRealmModel = self.taskRealmModel;
        _headerView = headerView;
    }
    return _headerView;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    
    [self.tableView registerClass:[SQHistoryTableViewCell class] forCellReuseIdentifier:kIdentifierOfHistoryTableViewCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    if (self.taskRealmModel.isCreate == YES) {
        self.headerView.taskRealmModel = self.taskRealmModel;
        self.tableView.tableHeaderView = self.headerView;
    }
    [super viewWillAppear:animated];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfTaskDetailsRealmModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SQHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfHistoryTableViewCell];
    cell.taskDetailsModel = self.groupOfTaskDetailsRealmModel[indexPath.row];
    cell.index = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *imageName = @"placeholder_empty";
    return [UIImage imageNamed:imageName];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"Task is empty";
    UIFont *font = kSQDefaultFontBoldWith(16);
    UIColor *textColor = kSQColorDefaultSecondaryTextBlackColor;
    [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSString *text  = @"When you create or record a task,\nthey will be shown up here.";
    UIFont *font = kSQDefaultFontRegularWith(14);
    UIColor *textColor = kSQColorDefaultTertiaryTextBlackColor;
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text = @"Get Started";
    UIFont *font = kSQDefaultFontBoldWith(14);
    UIColor *textColor = kSQColorDefaultSecondaryTextWhiteColor;
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *imageName = @"button_background_empty";
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
    capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
    rectInsets = UIEdgeInsetsMake(0.0, -20, 0.0, -20);
    return [[[UIImage imageNamed:imageName] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return kSQColorDefaultBackgroundWhiteColor;
}

#pragma mark - DZNEmptyDataSetDelegate
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    self.groupOfTaskDetailsRealmModel = nil;
    SQTaskRealmModel *taskRealmModel = self.taskRealmModel;
    if (taskRealmModel.isCreate == YES) {
        SQRecordViewController *recordVC = [[SQRecordViewController alloc] init];
        recordVC.taskModel = taskRealmModel;
        [self.navigationController pushViewController:recordVC animated:YES];
    }else {
        SQCreatNewTaskViewController *creatNewTaskVC = [[SQCreatNewTaskViewController alloc] init];
        creatNewTaskVC.taskModel = taskRealmModel;
        [self presentViewController:creatNewTaskVC animated:YES completion:^{
        }];
    }
}

@end
