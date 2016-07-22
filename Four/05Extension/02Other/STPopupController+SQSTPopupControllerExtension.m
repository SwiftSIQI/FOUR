//
//  STPopupController+SQSTPopupControllerExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/18.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "STPopupController+SQSTPopupControllerExtension.h"

@implementation STPopupController (SQSTPopupControllerExtension)

+ (STPopupController *)sq_defalutPopupControllerWithRootVC:(UIViewController *)rootVC{
    
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:rootVC];
    //设置弹出框的blur效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    popupController.backgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //设置圆角
    popupController.containerView.layer.cornerRadius = kPopupCornerRadius;
    
    //设置STPopupController的Navi
    [STPopupNavigationBar appearance].barTintColor = kSQColorDefaultPopupBlackColor;
    [STPopupNavigationBar appearance].tintColor = [UIColor whiteColor];
    [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
    
    
    return popupController;
}


@end
