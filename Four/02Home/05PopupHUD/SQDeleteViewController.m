//
//  SQDeleteViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQDeleteViewController.h"

@interface SQDeleteViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation SQDeleteViewController

#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultOrangeColor textAlignment:NSTextAlignmentCenter];
        label.text = @"Warning";
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [UILabel sq_tertiaryLabelWithColor:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentCenter];
        label.text = @"Tap the button, and all of the task records will be deleted.";
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        UIButton *button = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultOrangeColor titleString:@"Delete"];
        [button addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton = button;
    }
    return _deleteButton;
}

#pragma mark - Alloc/Init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.contentSizeInPopup = CGSizeMake(kPopupViewWidth, kPopupDeleteViewHeight);
        self.view.backgroundColor = kSQColorDefaultPopupWhiteColor;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma  mark - 响应事件
- (void)deleteButtonClick{
    NSDictionary *userInfo = @{@"taskColor": self.taskColor};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSQDeleteTaskNotification object:nil userInfo:userInfo];
    [self.popupController dismiss];
}

#pragma mark - 内部方法
- (void)setupUI{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.deleteButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kMiddleMargin);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(kLargeMargin);
        make.right.equalTo(self.view.mas_right).offset(-kLargeMargin);
        make.height.equalTo(@80);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kMiddleMargin);
        make.left.equalTo(self.view.mas_left).offset(kMiddleMargin);
        make.right.equalTo(self.view.mas_right).offset(-kMiddleMargin);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kMiddleMargin);
    }];
}

@end
