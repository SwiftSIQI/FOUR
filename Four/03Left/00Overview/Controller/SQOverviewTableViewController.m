//
//  SQOverviewTableViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQOverviewTableViewController.h"

@interface SQOverviewTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) RLMResults<SQTaskRealmModel *> *groupOfTaskRealmModel;

@end

@implementation SQOverviewTableViewController
#pragma mark - 懒加载
- (RLMResults *)groupOfTaskRealmModel{
    if(_groupOfTaskRealmModel == nil){
        //搜索数据库数据
        RLMResults *result = [SQTaskRealmModel objectsWhere:@"isCreate = YES"];
        
        _groupOfTaskRealmModel = result;
    }
    return _groupOfTaskRealmModel;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SQOverviewTableViewCell class] forCellReuseIdentifier:kIdentifierOfOverviewTableViewCell];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
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
    return self.groupOfTaskRealmModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfOverviewTableViewCell forIndexPath:indexPath];
    cell.taskRealmModel = self.groupOfTaskRealmModel[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = (kScreenHeight - kStatusBarHeight - kNavigationBarHeight) / self.groupOfTaskRealmModel.count;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SQPieChartViewController *pieChartVC = [[SQPieChartViewController alloc] init];
    pieChartVC.taskRealmModel = self.groupOfTaskRealmModel[indexPath.row];
    pieChartVC.transitioningDelegate = self;
    pieChartVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:pieChartVC animated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    return [[SQPresentingAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[SQDismissingAnimator alloc] init];
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
    SQCreatNewTaskViewController *creatNewTaskVC = [[SQCreatNewTaskViewController alloc] init];
    RLMResults <SQTaskRealmModel *> *result = [SQTaskRealmModel allObjects];
    creatNewTaskVC.taskModel = result[0];
    [self presentViewController:creatNewTaskVC animated:YES completion:^{
    }];
}

@end
