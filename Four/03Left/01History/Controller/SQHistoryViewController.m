//
//  SQHistoryViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/30.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHistoryViewController.h"

@interface SQHistoryViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIView *indicativeView;
@property (nonatomic, strong) UIImageView *indicativeImageView;
@property (nonatomic, strong) RLMResults<SQTaskRealmModel *> *groupOfTaskRealmModel;
@end

@implementation SQHistoryViewController
#pragma mark - 懒加载
- (RLMResults *)groupOfTaskRealmModel{
    if(_groupOfTaskRealmModel == nil){
        //搜索数据库数据
        RLMResults *result = [SQTaskRealmModel allObjects];
        _groupOfTaskRealmModel = result;
    }
    return _groupOfTaskRealmModel;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];
    [self setupChildViewController];
    [self setupScrollView];
    [self setupTitleView];
    [self addChildView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGroupOfTaskRealmModel) name:kSQCreateTaskNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - 布局方法
- (void)setupChildViewController{
    for (int i = 0; i < self.groupOfTaskRealmModel.count; i++) {
        SQHistoryTableViewController *tableVC = [[SQHistoryTableViewController alloc] init];
        [self addChildViewController:tableVC];
    }
}

- (void)setupScrollView{
    CGRect rect = CGRectMake(0, kTableViewTitleViewHeight, kScreenWidht, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTableViewTitleViewHeight);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView = scrollView;
    scrollView.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //向viewController中添加scrollView
    [self.view addSubview:scrollView];
    //子控制器个数
    NSUInteger childViewControllersCount = self.childViewControllers.count;
    //设置scrollView的大小
    scrollView.contentSize = CGSizeMake(childViewControllersCount * kScreenWidht, 0);
}

- (void)setupTitleView{
    //添加titleView主体
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    titleView.frame = CGRectMake(0, 0, kScreenWidht, kTableViewTitleViewHeight);
    titleView.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
    NSInteger titleCount = self.groupOfTaskRealmModel.count;
    CGFloat titleButtonWidth = kScreenWidht / titleCount;
    CGFloat titleButtonHeigth = kTableViewTitleViewHeight;
    
    //在titleView中添加button
    for (int i = 0; i < titleCount; i++) {
        //基本设置
        SQTitleViewButton *titleViewButton = [SQTitleViewButton buttonWithType:UIButtonTypeCustom];
        //取出模型
        SQTaskRealmModel *taskRealmModel = self.groupOfTaskRealmModel[i];
        titleViewButton.tag = i;
        titleViewButton.frame = CGRectMake(i * titleButtonWidth, 0, titleButtonWidth, titleButtonHeigth);
        titleViewButton.backgroundColor = [UIColor sq_getDefalutColorByStringName:taskRealmModel.taskColor];
        [titleViewButton setTitle:taskRealmModel.taskName forState:UIControlStateNormal];
        //监听button的点击事件
        [titleViewButton addTarget:self action:@selector(titleViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加button到titleView
        [titleView addSubview:titleViewButton];
    }
    
    //取出titleView中的第一个button
    UIButton *firstTitleViewButton = titleView.subviews.firstObject;
    //提前计算firstTitleViewButton的titleLabel大小
    [firstTitleViewButton.titleLabel sizeToFit];
    //改变firstTitleViewButton的状态为selected
    firstTitleViewButton.selected = YES;
    //赋值
    self.selectedButton = firstTitleViewButton;
    //设置titleViewButton底部的indicativeLineView
    CGRect indicativeViewFrame = CGRectMake(1, titleButtonHeigth, titleButtonWidth - 2, 1);
    UIView *indicativeView = [[UIView alloc] initWithFrame:indicativeViewFrame];
    indicativeView.backgroundColor = firstTitleViewButton.backgroundColor;
    self.indicativeView = indicativeView;
    
    CGRect indicativeImageViewFrame = firstTitleViewButton.frame;
    UIImageView *indicativeImageView = [[UIImageView alloc] initWithFrame:indicativeImageViewFrame];
    indicativeImageView.image = [UIImage imageNamed:@"outline"];
    indicativeImageView.contentMode = UIViewContentModeScaleAspectFill;
    indicativeImageView.clipsToBounds = YES;
    indicativeImageView.userInteractionEnabled = NO;
    self.indicativeImageView = indicativeImageView;
    
    
    //保持indicativeLineView的颜色与字体的selected状态下相同
    [titleView addSubview:indicativeImageView];
    [titleView addSubview:indicativeView];
    [self.view addSubview:titleView];
}

- (void)addChildView{
    //计算tableView的编号
    NSUInteger index = self.scrollView.contentOffset.x / kScreenWidht;
    //取出对应的tableView
    SQHistoryTableViewController *childTableViewController = self.childViewControllers[index];
    //如果当前TableViewController的view被加载了,就不需要再加载
    if (childTableViewController.isViewLoaded) {
        return;
    }
    //为tabelView设置模型数据
    childTableViewController.taskRealmModel = self.groupOfTaskRealmModel[index];
    //获取tableView
    UITableView *tableView = childTableViewController.tableView;
    //设定tabelView的frame值
    tableView.frame = self.scrollView.bounds;
    //设置tableView右侧滑块指示器的内边距
    tableView.scrollIndicatorInsets = tableView.contentInset;
    //将childTableView添加到scrollView
    [self.scrollView addSubview:childTableViewController.tableView];
}


#pragma mark - 监听方法
- (void)titleViewButtonClick:(SQTitleViewButton *)button{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    CGRect indicativeViewRect = self.indicativeView.frame;
    indicativeViewRect.origin.x = button.frame.origin.x + 1;
    indicativeViewRect.size.width = button.frame.size.width - 2;
    
    CGRect indicativeImageViewRect = self.indicativeImageView.frame;
    indicativeImageViewRect = button.frame;
    
    
    
    [UIView animateWithDuration:0.28 animations:^{
        self.indicativeView.backgroundColor = button.backgroundColor;
        self.indicativeView.frame = indicativeViewRect;
        self.indicativeImageView.frame = indicativeImageViewRect;
    }];
    //计算点击button后,scrollView的偏移量
    CGPoint offset = self.scrollView.contentOffset;
    //利用button的tag值计算偏移量
    offset.x = button.tag * kScreenWidht;
    //滚动scrllView到对应的位置
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)updateGroupOfTaskRealmModel{
    //获取TaskRealmModel,并更新自身的groupOfTaskRealmModel属性
    self.groupOfTaskRealmModel = [SQTaskRealmModel allObjects];

    for (int i = 0 ; i < self.groupOfTaskRealmModel.count; i++) {
        //取出对应的TaskRealmModel
        SQTaskRealmModel *taskRealmModel = self.groupOfTaskRealmModel[i];
        //更新button的Title
        UIButton *button = self.titleView.subviews[i];
        [button setTitle:taskRealmModel.taskName forState:UIControlStateNormal];
        //更新tableViewController的数据
        SQHistoryTableViewController *tabVC = self.childViewControllers[i];
        tabVC.taskRealmModel = taskRealmModel;
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self addChildView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = self.scrollView.contentOffset.x / kScreenWidht;
    SQTitleViewButton *button = self.titleView.subviews[index];
    [self titleViewButtonClick:button];
    [self addChildView];
}

@end
