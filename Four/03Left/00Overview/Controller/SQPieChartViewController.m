//
//  SQPieChartViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQPieChartViewController.h"

@interface SQPieChartViewController () <XYPieChartDataSource,XYPieChartDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *taskNameLabel;
@property (nonatomic, strong) XYPieChart *pieChartView;
@property (nonatomic, strong) UIView *detailContentView;
@property (nonatomic, strong) UILabel *finishedLabel;
@property (nonatomic, strong) UILabel *unfinishedLabel;
@property (nonatomic, strong) UIImageView *finishedImageView;
@property (nonatomic, strong) UIImageView *unfinishedImageView;

@property (nonatomic, strong) NSArray <NSDictionary *> *chartData;

@end

@implementation SQPieChartViewController
#pragma mark - 重写TaskRealmModel方法
- (void)setTaskRealmModel:(SQTaskRealmModel *)taskRealmModel{
    _taskRealmModel = taskRealmModel;
    
    NSTimeInterval timeInterval = [taskRealmModel.timeTotal timeIntervalSince1970];
    NSInteger time = timeInterval;
    
    NSDictionary *finishedTimeDict = @{
                           @"timeValue" : [NSNumber numberWithInteger:time / 3600] ,
                           @"string" : [NSString sq_getExecutedTimeStringbyTimeInterval:timeInterval]
                           };
    
    NSDictionary *unfinishedTimeDict = @{
                                       @"timeValue" : [NSNumber numberWithInteger:(10000 * 60 * 60 - time) / 3600] ,
                                       @"string" : [NSString sq_getExecutedTimeStringbyTimeInterval:10000 * 60 * 60 - time]
                                       };
    
    self.chartData = @[finishedTimeDict, unfinishedTimeDict];
    
    self.containerView.backgroundColor = [UIColor sq_getDefalutColorByStringName:taskRealmModel.taskColor];

    self.taskNameLabel.text = taskRealmModel.taskName;
    self.finishedLabel.text = @"Have Done";
    self.unfinishedLabel.text = @"Still Need";
}

- (void)setChartData:(NSArray<NSDictionary *> *)chartData{
    _chartData = chartData;
}

#pragma mark - 懒加载
- (UIView *)containerView{
    if (_containerView == nil) {
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = 15;
        view.layer.shadowRadius = 17;
        view.layer.shadowOpacity = 0.5;
        view.layer.shadowOffset = CGSizeMake(3, 3);
        view.layer.shadowColor = kSQColorDefaultBlackColor.CGColor;
        _containerView = view;
    }
    return _containerView;
}

- (UILabel *)taskNameLabel{
    if (_taskNameLabel == nil) {
        UILabel *label = [UILabel sq_primaryLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = NO;
        _taskNameLabel = label;
    }
    return _taskNameLabel;
}

- (UIView *)detailContentView{
    if (_detailContentView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.userInteractionEnabled = NO;
        _detailContentView = view;
    }
    return _detailContentView;
}

- (UILabel *)finishedLabel{
    if (_finishedLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultBoldFontSize:20 Color:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentLeft];
        _finishedLabel = label;
    }
    return _finishedLabel;
}

- (UILabel *)unfinishedLabel{
    if (_unfinishedLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultBoldFontSize:20 Color:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentLeft];
        _unfinishedLabel = label;
    }
    return _unfinishedLabel;
}

- (UIImageView *)finishedImageView{
    if (_finishedImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kSQColorDefaultPrimaryTextWhiteColor;
        _finishedImageView = imageView;
    }
    return _finishedImageView;
}

- (UIImageView *)unfinishedImageView{
    if (_unfinishedImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kSQColorDefaultPrimaryTextBlackColor;
        _unfinishedImageView = imageView;
    }
    return _unfinishedImageView;
}

- (XYPieChart *)pieChartView{
    if (_pieChartView == nil) {
        CGFloat radius = kSQPieChartViewPieChartWidth * 0.5 - 2 * kLargeMargin;
        CGPoint center = CGPointMake(kSQPieChartViewPieChartWidth * 0.5, kSQPieChartViewPieChartHeight * 0.5);
        XYPieChart *pieChartView = [[XYPieChart alloc] initWithFrame:CGRectMake(0, 0, 0, 0) Center:center Radius:radius];
        pieChartView.dataSource = self;
        pieChartView.delegate = self;
        
        [pieChartView setAnimationSpeed:1.2];
    
        _pieChartView = pieChartView;
    }
    return _pieChartView;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.pieChartView reloadData];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 布局方法
- (void)setupUI{
    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.taskNameLabel];
    [self.containerView addSubview:self.pieChartView];
    [self.containerView addSubview:self.detailContentView];
    [self.detailContentView addSubview:self.finishedLabel];
    [self.detailContentView addSubview:self.unfinishedLabel];
    [self.detailContentView addSubview:self.finishedImageView];
    [self.detailContentView addSubview:self.unfinishedImageView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_top).offset(2 * kLargeMargin);
        make.left.equalTo(self.containerView.mas_left);
        make.right.equalTo(self.containerView.mas_right);
        make.height.equalTo(@(100));
    }];

    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskNameLabel.mas_bottom);
        make.left.equalTo(self.containerView.mas_left);
        make.right.equalTo(self.containerView.mas_right);
        make.height.equalTo(@(kSQPieChartViewPieChartHeight));
    }];
    
    [self.detailContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pieChartView.mas_bottom);
        make.bottom.equalTo(self.containerView.mas_bottom);
        make.left.equalTo(self.containerView.mas_left);
        make.right.equalTo(self.containerView.mas_right);
    }];
    
    [self.finishedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailContentView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.detailContentView.mas_centerY).offset(-15);
        make.width.equalTo(self.finishedLabel.mas_height);
        make.height.equalTo(self.finishedLabel.mas_height);
    }];

    [self.finishedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailContentView.mas_centerX).offset(20);
        make.centerY.equalTo(self.detailContentView.mas_centerY).offset(-15);
    }];

    [self.unfinishedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailContentView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.detailContentView.mas_centerY).offset(15);
        make.width.equalTo(self.finishedLabel.mas_height);
        make.height.equalTo(self.finishedLabel.mas_height);
    }];

    [self.unfinishedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailContentView.mas_centerX).offset(20);
        make.centerY.equalTo(self.detailContentView.mas_centerY).offset(15);
    }];
}

#pragma mark - 响应方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - XYPieChartDataSource
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    return self.chartData.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    NSNumber *number = self.chartData[index][@"timeValue"];
    return number.intValue;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index{
    UIColor *color = (index == 0)?  kSQColorDefaultWhiteColor: kSQColorDefaultBlackColor ;
    return color;
}


@end
