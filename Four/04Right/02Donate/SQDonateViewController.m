//
//  SQDonateViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/7.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQDonateViewController.h"

@interface SQDonateViewController () 


@property (nonatomic, strong) UILabel *topicLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *donateLabel;

@property (nonatomic, strong) SQDonateButtonView *donateLevel1Button;
@property (nonatomic, strong) SQDonateButtonView *donateLevel2Button;
@property (nonatomic, strong) SQDonateButtonView *donateLevel3Button;
@property (nonatomic, strong) SQDonateButtonView *donateLevel4Button;


@end

@implementation SQDonateViewController

#pragma mark - 懒加载
- (UILabel *)topicLabel{
    if (_topicLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"Sponsor Project";

        _topicLabel = label;
    }
    return _topicLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [UILabel sq_longLabelWithRegularFontSize:14 Color:kSQColorDefaultSecondaryTextWhiteColor textAlignment:NSTextAlignmentLeft linespacing:6 string:@"Every cent of your donation will go directly to developing our free and excellent apps. Your generous contribution will go a long way in helping us create more value in people\'s lives and make the world a better place."];

        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)donateLabel{
    if (_donateLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"Sponsor";
        _donateLabel = label;
    }
    return _donateLabel;
}

- (SQDonateButtonView *)donateLevel1Button{
    if (_donateLevel1Button == nil) {
        SQDonateButtonView *view = [[SQDonateButtonView alloc] initWithTitle:@"6 RMB" andImageName:@"donateLevel1"];
        view.tag = 0;
        _donateLevel1Button = view;
    }
    return _donateLevel1Button;
}

- (SQDonateButtonView *)donateLevel2Button{
    if (_donateLevel2Button == nil) {
        SQDonateButtonView *view = [[SQDonateButtonView alloc] initWithTitle:@"18 RMB" andImageName:@"donateLevel2"];
        view.tag = 1;

        _donateLevel2Button = view;
    }
    return _donateLevel2Button;
}

- (SQDonateButtonView *)donateLevel3Button{
    if (_donateLevel3Button == nil) {
        SQDonateButtonView *view = [[SQDonateButtonView alloc] initWithTitle:@"45 RMB" andImageName:@"donateLevel3"];
        view.tag = 2;

        _donateLevel3Button = view;
    }
    return _donateLevel3Button;
}

- (SQDonateButtonView *)donateLevel4Button{
    if (_donateLevel4Button == nil) {
        SQDonateButtonView *view = [[SQDonateButtonView alloc] initWithTitle:@"98 RMB" andImageName:@"donateLevel4"];
        view.tag = 3;

        _donateLevel4Button = view;
    }
    return _donateLevel4Button;
}



#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];

    self.view.backgroundColor = kSQColorDefaultBackgroundBlackColor;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 布局方法
- (void)setupUI{
    
    [self.view addSubview:self.topicLabel];
    [self.view addSubview:self.contentLabel];
    
    [self.view addSubview:self.donateLabel];
    [self.view addSubview:self.donateLevel1Button];
    [self.view addSubview:self.donateLevel2Button];
    [self.view addSubview:self.donateLevel3Button];
    [self.view addSubview:self.donateLevel4Button];

    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kInsertMargin);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
    
    [self.donateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
    
    [self.donateLevel1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.topicLabel.mas_left);
        make.height.equalTo(self.donateLevel1Button.mas_width).multipliedBy(1.3);
    }];
    
    [self.donateLevel2Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel1Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
    }];
    
    [self.donateLevel3Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel2Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
    }];
    
    [self.donateLevel4Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateLevel1Button);
        make.left.equalTo(self.donateLevel3Button.mas_right).offset(kMiddleMargin);
        make.width.equalTo(self.donateLevel1Button.mas_width);
        make.bottom.equalTo(self.donateLevel1Button.mas_bottom);
        make.right.equalTo(self.topicLabel.mas_right);
    }];
}

@end
