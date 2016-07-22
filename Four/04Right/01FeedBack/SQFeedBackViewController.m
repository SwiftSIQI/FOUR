//
//  SQFeedBackViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/6.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQFeedBackViewController.h"

@interface SQFeedBackViewController () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *introductionLabel;
@property (nonatomic, strong) UITextView *feedBackTextView;
@property (nonatomic, strong) UIView *feedbackTextViewTopLineView;
@property (nonatomic, strong) UIView *feedbackTextViewBottomLineView;

@property (nonatomic, assign) BOOL isEmpty;


@end

@implementation SQFeedBackViewController

#pragma mark - 懒加载
- (UILabel *)introductionLabel{
    if (_introductionLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentCenter];
        label.text = @"We Read Every Feedback";
        _introductionLabel = label;
    }
    return _introductionLabel;
}

- (UITextView *)feedBackTextView{
    if (_feedBackTextView == nil) {
        UITextView *textView = [[UITextView alloc] init];
        textView.font = kSQDefaultTertiaryFont;
        textView.text = @"";
        textView.delegate = self;
        textView.textContainerInset = UIEdgeInsetsMake(10, 12, 10, 12);
        textView.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
        _feedBackTextView = textView;
    }
    return _feedBackTextView;
}

- (UIView *)feedbackTextViewTopLineView{
    if (_feedbackTextViewTopLineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultBackgroundWhiteColor;
        _feedbackTextViewTopLineView = view;
    }
    return _feedbackTextViewTopLineView;
}

- (UIView *)feedbackTextViewBottomLineView{
    if (_feedbackTextViewBottomLineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultBackgroundBlackColor;
        _feedbackTextViewBottomLineView = view;
    }
    return _feedbackTextViewBottomLineView;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];

    self.isEmpty = YES;
    self.view.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonClick)];
    
    
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtonClick)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.feedBackTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.feedBackTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 布局方法
- (void)setupUI{
    [self.view addSubview:self.introductionLabel];
    [self.view addSubview:self.feedbackTextViewTopLineView];
    [self.view addSubview:self.feedBackTextView];
    [self.view addSubview:self.feedbackTextViewBottomLineView];
    
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.feedbackTextViewTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introductionLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(kScreenWidht));
        make.height.equalTo(@(1));
    }];
    
    [self.feedbackTextViewBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(kScreenWidht));
        make.height.equalTo(@(40));
    }];
    
    [self.feedBackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedbackTextViewTopLineView.mas_bottom);
        make.bottom.equalTo(self.feedbackTextViewBottomLineView.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(kScreenWidht));
    }];
}


#pragma mark - 响应方法
- (void)doneButtonClick{
    
}

- (void)tapButtonClick{
    [self.feedBackTextView resignFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{

}

@end
