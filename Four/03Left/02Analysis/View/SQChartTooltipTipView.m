//
//  SQChartTooltipTipView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/2.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQChartTooltipTipView.h"



@implementation SQChartTooltipTipView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kSQChartTooltipTipViewDefaultWidth, kSQChartTooltipTipViewDefaultHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(context, rect);
    
    CGContextSaveGState(context);
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, kSQColorDefaultPopupWhiteColor.CGColor);
        CGContextFillPath(context);
    }
    CGContextRestoreGState(context);
}

@end
