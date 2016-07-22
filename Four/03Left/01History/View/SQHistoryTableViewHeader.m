//
//  SQHistoryTableViewHeader.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHistoryTableViewHeader.h"

@interface SQHistoryTableViewHeader()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *taskNameLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UIView *separaterBottomView;
@property (nonatomic, strong) UIView *separaterTopView;
@property (nonatomic, strong) UIView *separaterLeftView;
@property (nonatomic, strong) UIView *separaterRightView;




@end

@implementation SQHistoryTableViewHeader
#pragma mark - 重写TaskRealmModel的set方法
- (void)setTaskRealmModel:(SQTaskRealmModel *)taskRealmModel{
    _taskRealmModel = taskRealmModel;
    //设置任务名称
    self.taskNameLabel.text = taskRealmModel.taskName;
    //设置任务时间
    NSTimeInterval timeInterval = [taskRealmModel.timeTotal timeIntervalSince1970];
    NSString *totalTimeString = [NSString sq_getExecutedTimeStringbyTimeInterval:timeInterval];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"Total Time is \n %@ ", totalTimeString];
    //设置任务的背景色
    self.backgroundColor = [UIColor sq_getDefalutColorByStringName:taskRealmModel.taskColor];
}

#pragma mark - 懒加载
- (UIView *)contentView{
    if (_contentView == nil) {
        UIView *view = [[UIView alloc] init];
        _contentView = view;
    }
    return _contentView;
}

- (UILabel *)taskNameLabel{
    if (_taskNameLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultBoldFontSize:60 Color:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentLeft];
        _taskNameLabel = label;
    }
    return _taskNameLabel;
}

- (UILabel *)totalTimeLabel{
    if (_totalTimeLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultRegularFontSize:24 Color:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentRight];
        _totalTimeLabel = label;
    }
    return _totalTimeLabel;
}

- (UIView *)separaterBottomView{
    if (_separaterBottomView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultGreyColor;
        _separaterBottomView = view;
    }
    return _separaterBottomView;
}

- (UIView *)separaterTopView{
    if (_separaterTopView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultBlackColor;
        _separaterTopView = view;
    }
    return _separaterTopView;
}

- (UIView *)separaterLeftView{
    if (_separaterLeftView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultBlackColor;
        _separaterLeftView = view;
    }
    return _separaterLeftView;
}

- (UIView *)separaterRightView{
    if (_separaterRightView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultBlackColor;
        _separaterRightView = view;
    }
    return _separaterRightView;
}


#pragma mark - alloc/init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.taskNameLabel];
        [self.contentView addSubview:self.totalTimeLabel];
        [self.contentView addSubview:self.separaterBottomView];
        [self.contentView addSubview:self.separaterTopView];
        [self.contentView addSubview:self.separaterLeftView];
        [self.contentView addSubview:self.separaterRightView];

    }
    return self;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 布局方法
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kSmallMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kSmallMargin);
        make.left.equalTo(self.contentView.mas_left).offset(kSmallMargin);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kSmallMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kSmallMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-kSmallMargin);
        make.left.equalTo(self.taskNameLabel.mas_right).offset(kSmallMargin);
    }];
    
    [self.separaterBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    [self.separaterTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    [self.separaterLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(@(1));
    }];
    
    [self.separaterRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.width.equalTo(@(1));
    }];
}

@end
