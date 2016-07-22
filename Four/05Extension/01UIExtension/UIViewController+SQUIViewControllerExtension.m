//
//  UIViewController+SQUIViewControllerExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "UIViewController+SQUIViewControllerExtension.h"

@implementation UIViewController (SQUIViewControllerExtension)

+ (void)pushViewControllerByNavigationVCInRevealVCFront:(UIViewController *)vc{
    //根控制器
    PKRevealController *revealController = (PKRevealController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //弹出主界面控制器
    [revealController showViewController:revealController.frontViewController animated:YES completion:^(BOOL finished) {
        //获取主界面控制器的NavigationVC
        UINavigationController *naviVC = (UINavigationController *)revealController.frontViewController;
        //Push新创建的VC
        [naviVC pushViewController:vc animated:YES];
    }];
}

@end
