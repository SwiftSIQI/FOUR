//
//  SQChartHeaderView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/2.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQChartHeaderView.h"



// Colors
static UIColor *kSQChartHeaderViewDefaultSeparatorColor = nil;

@interface SQChartHeaderView ()

@property (nonatomic, strong) UIView *separatorView;

@end

@implementation SQChartHeaderView

#pragma mark - Alloc/Init

+ (void)initialize{
    if (self == [SQChartHeaderView class]){
        kSQChartHeaderViewDefaultSeparatorColor = [UIColor whiteColor];
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = kSQDefaultSecondaryBoldFont;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.numberOfLines = 1;
        _subtitleLabel.adjustsFontSizeToFitWidth = YES;
        _subtitleLabel.font = kSQDefaultTertiaryFont;
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = [UIColor whiteColor];
        _subtitleLabel.shadowColor = [UIColor blackColor];
        _subtitleLabel.shadowOffset = CGSizeMake(0, 1);
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_subtitleLabel];
        
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = kSQChartHeaderViewDefaultSeparatorColor;
        [self addSubview:_separatorView];
    }
    return self;
}

#pragma mark - Setters

- (void)setSeparatorColor:(UIColor *)separatorColor{
    _separatorColor = separatorColor;
    self.separatorView.backgroundColor = _separatorColor;
    [self setNeedsLayout];
}

#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat titleHeight = ceil(self.bounds.size.height * 0.5);
    CGFloat subTitleHeight = self.bounds.size.height - titleHeight - kSQChartHeaderViewSeparatorHeight;
    CGFloat xOffset = kSQChartHeaderViewPadding;
    CGFloat yOffset = 0;
    
    self.titleLabel.frame = CGRectMake(xOffset, yOffset, self.bounds.size.width - (xOffset * 2), titleHeight);
    yOffset += self.titleLabel.frame.size.height;
    self.separatorView.frame = CGRectMake(xOffset * 2, yOffset, self.bounds.size.width - (xOffset * 4), kSQChartHeaderViewSeparatorHeight);
    yOffset += self.separatorView.frame.size.height;
    self.subtitleLabel.frame = CGRectMake(xOffset, yOffset, self.bounds.size.width - (xOffset * 2), subTitleHeight);
}

@end
