//
//  SQNavigationController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/21.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQNavigationController.h"

@interface SQNavigationController ()

@end

@implementation SQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置NavigationBar的背景颜色
    [[UINavigationBar appearance] setBarTintColor:kSQColorDefaultBackgroundBlackColor];
    //设置NavigationBar的字体颜色
    [[UINavigationBar appearance] setTintColor:kSQColorDefaultPrimaryTextWhiteColor];
    //设置NavigationBar的字体样式
    NSDictionary *dict = @{
                           NSFontAttributeName: kSQDefaultFontBoldWith(20),
                           };
    [[UINavigationBar appearance] setTitleTextAttributes:dict];    
    //关闭自动下移
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationBar.translucent = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
