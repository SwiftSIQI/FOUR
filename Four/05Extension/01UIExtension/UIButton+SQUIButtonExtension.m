//
//  UIButton+SQUIButtonExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/18.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "UIButton+SQUIButtonExtension.h"

@implementation UIButton (SQUIButtonExtension)

+ (UIButton *)sq_defaultButtonWithBackgroundColor:(UIColor *)color titleString:(NSString *)titleString{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = kSQDefaultFontBoldWith(kButtonFontSize);
    button.layer.cornerRadius = kButtonCornerRadius;
    [button setTitle:titleString forState:UIControlStateNormal];
    [button setTitleColor:kSQColorDefaultPrimaryTextWhiteColor forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    return button;
}

@end
