//
//  SQAnalysisCollectionViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAnalysisCollectionViewController.h"

@interface SQAnalysisCollectionViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, assign) BOOL isTaskCreated;

@end

@implementation SQAnalysisCollectionViewController
- (BOOL)isTaskCreated{
    BOOL flag = NO;
    //取出所有的任务模型
    RLMResults <SQTaskRealmModel *> *result = [SQTaskRealmModel allObjects];
    for (SQTaskRealmModel *taskModel in result) {
        //判断任务模型是否被创建过
        if (taskModel.isCreate == YES) {
            flag = YES;
        }
    }
    return flag;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];
    [self.collectionView registerClass:[SQAnalysisCollectionViewCell class] forCellWithReuseIdentifier:kIdentifierOfAnalysisCollectionViewCell];
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
    //禁用PKRevealController的手势
    PKRevealController *rootVC = (PKRevealController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    rootVC.recognizesPanningOnFrontView = NO;
    rootVC.recognizesResetTapOnFrontView = NO;
    rootVC.recognizesResetTapOnFrontViewInPresentationMode = NO;
    
    //禁用系统的返回手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    PKRevealController *rootVC = (PKRevealController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    rootVC.recognizesPanningOnFrontView = YES;
    rootVC.recognizesResetTapOnFrontView = YES;
    rootVC.recognizesResetTapOnFrontViewInPresentationMode = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    [super viewWillDisappear:animated];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger number = 0;
    if (self.isTaskCreated == YES) {
        number = kChartTypeNumber;
    }
    return number;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQAnalysisCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifierOfAnalysisCollectionViewCell forIndexPath:indexPath];
    cell.type = indexPath.row;
    cell.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
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
    SQCreatNewTaskViewController *creatNewTaskVC = [[SQCreatNewTaskViewController alloc] init];
    RLMResults <SQTaskRealmModel *> *result = [SQTaskRealmModel allObjects];
    creatNewTaskVC.taskModel = result[0];
    [self presentViewController:creatNewTaskVC animated:YES completion:^{
    }];
}

@end
