//
//  SQDonateButtonView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/7.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQDonateButtonView.h"

@interface SQDonateButtonView () <SKProductsRequestDelegate>

@property (nonatomic, strong) UIImageView *donateImageView;
@property (nonatomic, strong) UIButton *donateButton;
@property (nonatomic, strong) NSString *productIdentifier;

@end

@implementation SQDonateButtonView
#pragma mark - 懒加载
- (UIImageView *)donateImageView{
    if (_donateImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donate)];
        [imageView addGestureRecognizer:pan];
        _donateImageView = imageView;
    }
    return _donateImageView;
}

- (UIButton *)donateButton{
    if (_donateButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = kSQColorDefaultWhiteColor;
        button.titleLabel.font = kSQDefaultFontBoldWith(14);
        [button setTitleColor:kSQColorDefaultPrimaryTextBlackColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(donate) forControlEvents:UIControlEventTouchUpInside];
        _donateButton = button;
    }
    return _donateButton;
}

- (NSString *)productIdentifier{
    if (_productIdentifier == nil) {
        NSString *string = [NSArray sq_getArrayOfProductIdentifierString][self.tag];
        _productIdentifier = string;
    }
    return _productIdentifier;
}

#pragma mark - alloc/init
- (instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        [self.donateButton setTitle:title forState:UIControlStateNormal];
        self.donateImageView.image = [UIImage imageNamed:imageName];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.donateImageView];
        [self addSubview:self.donateButton];
        
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

    [self.donateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.donateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.donateImageView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_width).multipliedBy(0.3);
    }];
}

#pragma mark - 响应方法

- (void)donate{
        //根据tag确定购买的商品标识
        NSSet *productIdentifier = [[NSSet alloc] initWithObjects:self.productIdentifier, nil];
        //创建购买商品的请求
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifier];
        //设置代理,监听请求的状态
        request.delegate = self;
        //发送请求
        [request start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    //获取SKProduct
    for (SKProduct *product in response.products) {
        [[IAPShare sharedHelper].iap buyProduct:product onCompletion:nil];
    }
}

@end
