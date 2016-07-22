//
//  SQAlertViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAlertViewController.h"

@interface SQAlertViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation SQAlertViewController
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultOrangeColor textAlignment:NSTextAlignmentCenter];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [UILabel sq_tertiaryLabelWithColor:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentCenter];
        _contentLabel = label;
    }
    return _contentLabel;
}

#pragma mark - Alloc/Init
- (instancetype)initWithTitleString:(NSString *)title contentString:(NSString *)content contentSize:(CGSize)size rightBarButtonTitle:(NSString *)rightBarTitleName{
    
    self = [super init];
    if (self) {
        //基本设置
        self.contentSizeInPopup = size;
        self.view.backgroundColor = kSQColorDefaultPopupWhiteColor;
        //设置子控件
        self.titleLabel.text = title;
        self.contentLabel.text = content;
        
        //如果标题名为Success,就使用青色,否则使用红色
        self.titleLabel.textColor = ([title isEqualToString:@"Success"]) ? kSQColorDefaultLimeColor : kSQColorDefaultOrangeColor;
            
        //设置Navigation Bar右上角的Next按钮
        if ([rightBarTitleName isEqualToString:@"Next"]) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnClick)];
        }
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

#pragma mark - 布局方法
- (void)setupUI{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kLargeMargin);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(kLargeMargin);
        make.right.equalTo(self.view.mas_right).offset(-kLargeMargin);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 响应方法
- (void)nextBtnClick{
    SQDeleteViewController *deleteVC = [[SQDeleteViewController alloc] init];
    deleteVC.taskColor = self.taskColor;
    [self.popupController pushViewController:deleteVC animated:YES];
}
@end
