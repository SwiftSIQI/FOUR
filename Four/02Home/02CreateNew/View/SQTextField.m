//
//  SQTextField.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/26.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQTextField.h"

@implementation SQTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置字体及大小
        self.font = kSQDefaultFontRegularWith(18);
        //设置字体颜色
        self.textColor = kSQColorDefaultPrimaryTextBlackColor;
        //设置占位字符颜色
        [self setValue:kSQColorDefaultTertiaryTextWhiteColor forKeyPath:@"placeholderLabel.textColor"];
        //设置光标颜色
        self.tintColor = kSQColorDefaultSecondaryTextWhiteColor;
        //设置背景色
        self.backgroundColor = kSQColorDefaultGreyColor;
        //设置圆角
        self.layer.cornerRadius = kTextViewCornerRadius;
    }
    return self;
}


#pragma mark - 调整文本框的编辑区域
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 3);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 3);
}

@end
