//
//  SQAboutUsTableViewHeader.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/6.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAboutUsTableViewHeader.h"

@interface SQAboutUsTableViewHeader()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *appNameImageView;
@property (nonatomic, strong) UILabel *versionLabel;

@end

@implementation SQAboutUsTableViewHeader

#pragma mark - 懒加载
- (UIView *)contentView{
    if(_contentView == nil){
        UIView *view = [[UIView alloc] init];
        _contentView = view;
    }
    return _contentView;
}

- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainIcon"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView = imageView;
    }
    return _logoImageView;
}

- (UIImageView *)appNameImageView{
    if (_appNameImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainTitle"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _appNameImageView = imageView;
    }
    return _appNameImageView;
}

- (UILabel *)versionLabel{
    if (_versionLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kSQDefaultTertiaryFont;
        label.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Version 1.0.0";
        _versionLabel = label;
    }
    return _versionLabel;
}

#pragma mark - init/alloc
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.logoImageView];
        [self.contentView addSubview:self.appNameImageView];
        [self.contentView addSubview:self.versionLabel];
    }
    return self;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 布局控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-40);
    }];
    
    [self.appNameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(125));
        make.height.equalTo(@(35));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(40);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(120);
    }];
}

@end
