//
//  SQChartTooltipView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/2.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQChartTooltipView.h"

@interface SQChartTooltipView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SQChartTooltipView

#pragma mark - Alloc/Init
- (id)init{
    self = [super initWithFrame:CGRectMake(0, 0, kSQChartTooltipViewDefaultWidth, kSQChartTooltipViewDefaultHeight)];
    if (self){
        self.backgroundColor = kSQColorDefaultPopupWhiteColor;
        self.layer.cornerRadius = kSQChartTooltipViewCornerRadius;
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = kSQDefaultTertiaryFont;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = kSQColorDefaultSecondaryTextBlackColor;
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.numberOfLines = 1;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

#pragma mark - Setters
- (void)setText:(NSString *)text{
    self.textLabel.text = text;
    [self setNeedsLayout];
}

- (void)setTooltipColor:(UIColor *)tooltipColor{
    self.backgroundColor = tooltipColor;
    [self setNeedsDisplay];
}

#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
}

@end
