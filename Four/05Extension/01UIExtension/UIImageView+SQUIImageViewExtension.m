//
//  UIImageView+SQUIImageViewExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/20.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "UIImageView+SQUIImageViewExtension.h"

@implementation UIImageView (SQUIImageViewExtension)

+ (instancetype)sq_getDefaultTitleImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainTitle"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, kNaviTitleViewWidth, kNaviTitleViewHeight);
    return imageView;
}

@end
