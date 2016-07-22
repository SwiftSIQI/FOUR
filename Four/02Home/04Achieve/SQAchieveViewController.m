//
//  SQAchieveViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/12.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAchieveViewController.h"

@interface SQAchieveViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation SQAchieveViewController
#pragma mark - getter
- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"achieve_back"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel * label = [UILabel sq_labelWithDefaultBoldFontSize:44 Color:kSQColorDefaultAmberColor textAlignment:NSTextAlignmentCenter];
        label.text = @"Congratulation";
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [UILabel sq_longLabelWithRegularFontSize:24 Color:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentCenter linespacing:8 string: @"You have successfully completed 10000 hours.Now go have a drink, Or three. Or five.....or stop counting and just go."];

        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)finishButton{
    if (_finishButton == nil) {
        UIButton *button = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultAmberColor titleString:@"Have A Drink"];
        [button addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _finishButton = button;
    }
    return _finishButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kSQColorAchieveViewBackgroundBlueColor;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (void)setupUI{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.finishButton];
    
    //__weak typeof(self) weakSelf = self;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(kScreenHeight / 2));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(3 * kLargeMargin));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2 * kLargeMargin);
        make.bottom.equalTo(self.finishButton.mas_top).offset(-2 * kLargeMargin);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(- kInsertMargin);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
        make.height.equalTo(@(4 * kLargeMargin));
    }];

}

- (void)finishButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
