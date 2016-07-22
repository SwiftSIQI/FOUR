//
//  SQTitleViewButton.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/29.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQTitleViewButton.h"

@implementation SQTitleViewButton

#pragma mark - alloc/init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:kSQColorDefaultTertiaryTextWhiteColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
        //设置字体大小
        self.titleLabel.font = kSQDefaultFontRegularWith(20);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    //不写任何代码,用于改变系统默认做法
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
