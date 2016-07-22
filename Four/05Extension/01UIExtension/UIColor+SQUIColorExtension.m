//
//  UIColor+SQUIColorExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/18.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "UIColor+SQUIColorExtension.h"

@implementation UIColor (SQUIColorExtension)

+ (UIColor *)sq_getDefalutColorByStringName:(NSString *)string{

    UIColor *color = kSQColorDefaultWhiteColor;
    if ([string isEqualToString:@"green"]) {
        color = kSQColorDefaultGreenColor;
    }else if ([string isEqualToString:@"red"]) {
        color = kSQColorDefaultRedColor;
    }else if ([string isEqualToString:@"blue"]) {
        color = kSQColorDefaultBlueColor;
    }else if ([string isEqualToString:@"yellow"]) {
        color = kSQColorDefaultYellowColor;
    }
    
    return color;
}


@end
