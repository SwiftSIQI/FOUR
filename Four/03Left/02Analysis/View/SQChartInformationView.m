//
//  SQChartInformationView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/2.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQChartInformationView.h"

@interface SQChartValueView : UIView

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *unitLabel;

@end

@interface SQChartInformationView ()

@property (nonatomic, strong) SQChartValueView *valueView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *separatorView;

// Position
- (CGRect)valueViewRect;
- (CGRect)titleViewRectForHidden:(BOOL)hidden;
- (CGRect)separatorViewRectForHidden:(BOOL)hidden;

@end

@implementation SQChartInformationView

#pragma mark - Alloc/Init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.clipsToBounds = YES;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kSQDefaultSecondaryBoldFont;
        _titleLabel.numberOfLines = 1;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kSQColorDefaultWhiteColor;
        _titleLabel.shadowColor = kSQColorDefaultBlackColor;
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = kSQColorDefaultWhiteColor;
        [self addSubview:_separatorView];
        
        _valueView = [[SQChartValueView alloc] initWithFrame:[self valueViewRect]];
        [self addSubview:_valueView];
        
        [self setHidden:YES animated:NO];
    }
    return self;
}

#pragma mark - Position
- (CGRect)valueViewRect{
    CGRect valueRect = CGRectZero;
    valueRect.origin.x = kSQChartValueViewPadding;
    valueRect.origin.y = kSQChartValueViewPadding + kSQChartValueViewTitleHeight;
    valueRect.size.width = self.bounds.size.width - (kSQChartValueViewPadding * 2);
    valueRect.size.height = self.bounds.size.height - valueRect.origin.y - kSQChartValueViewPadding;
    return valueRect;
}

- (CGRect)titleViewRectForHidden:(BOOL)hidden{
    CGRect titleRect = CGRectZero;
    titleRect.origin.x = kSQChartValueViewPadding;
    titleRect.origin.y = hidden ? -kSQChartValueViewTitleHeight : kSQChartValueViewPadding;
    titleRect.size.width = self.bounds.size.width - (kSQChartValueViewPadding * 2);
    titleRect.size.height = kSQChartValueViewTitleHeight;
    return titleRect;
}

- (CGRect)separatorViewRectForHidden:(BOOL)hidden{
    CGRect separatorRect = CGRectZero;
    separatorRect.origin.x = kSQChartValueViewPadding;
    separatorRect.origin.y = kSQChartValueViewTitleHeight;
    separatorRect.size.width = self.bounds.size.width - (kSQChartValueViewPadding * 2);
    separatorRect.size.height = kSQChartValueViewSeparatorSize;
    if (hidden)
    {
        separatorRect.origin.x -= self.bounds.size.width;
    }
    return separatorRect;
}

#pragma mark - Setters
- (void)setTextFontOfValueLabelInValueView:(UIFont *)font{
    self.valueView.valueLabel.font = font;
}

- (void)setTextFontOfUnitLabelInValueView:(UIFont *)font{
    self.valueView.unitLabel.font = font;
}

- (void)setTitleText:(NSString *)titleText{
    self.titleLabel.text = titleText;
    self.separatorView.hidden = !(titleText != nil);
}

- (void)setValueText:(NSString *)valueText unitText:(NSString *)unitText{
    self.valueView.valueLabel.text = valueText;
    self.valueView.unitLabel.text = unitText;
    [self.valueView setNeedsLayout];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor{
    self.titleLabel.textColor = titleTextColor;
    [self.valueView setNeedsDisplay];
}

- (void)setValueAndUnitTextColor:(UIColor *)valueAndUnitColor{
    self.valueView.valueLabel.textColor = valueAndUnitColor;
    self.valueView.unitLabel.textColor = valueAndUnitColor;
    [self.valueView setNeedsDisplay];
}

- (void)setTextShadowColor:(UIColor *)shadowColor{
    self.valueView.valueLabel.shadowColor = shadowColor;
    self.valueView.unitLabel.shadowColor = shadowColor;
    self.titleLabel.shadowColor = shadowColor;
    [self.valueView setNeedsDisplay];
}

- (void)setSeparatorColor:(UIColor *)separatorColor{
    self.separatorView.backgroundColor = separatorColor;
    [self setNeedsDisplay];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated{
    if (animated){
        if (hidden){
            [UIView animateWithDuration:kSQChartValueViewDefaultAnimationDuration * 0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.titleLabel.alpha = 0.0;
                self.separatorView.alpha = 0.0;
                self.valueView.valueLabel.alpha = 0.0;
                self.valueView.unitLabel.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.titleLabel.frame = [self titleViewRectForHidden:YES];
                self.separatorView.frame = [self separatorViewRectForHidden:YES];
            }];
        }
        else{
            [UIView animateWithDuration:kSQChartValueViewDefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.titleLabel.frame = [self titleViewRectForHidden:NO];
                self.titleLabel.alpha = 1.0;
                self.valueView.valueLabel.alpha = 1.0;
                self.valueView.unitLabel.alpha = 1.0;
                self.separatorView.frame = [self separatorViewRectForHidden:NO];
                self.separatorView.alpha = 1.0;
            } completion:nil];
        }
    }
    else{
        self.titleLabel.frame = [self titleViewRectForHidden:hidden];
        self.titleLabel.alpha = hidden ? 0.0 : 1.0;
        self.separatorView.frame = [self separatorViewRectForHidden:hidden];
        self.separatorView.alpha = hidden ? 0.0 : 1.0;
        self.valueView.valueLabel.alpha = hidden ? 0.0 : 1.0;
        self.valueView.unitLabel.alpha = hidden ? 0.0 : 1.0;
    }
}

- (void)setHidden:(BOOL)hidden{
    [self setHidden:hidden animated:NO];
}

@end

@implementation SQChartValueView
#pragma mark - Alloc/Init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = kSQDefaultPrimaryFont;
        _valueLabel.textColor = kSQColorDefaultWhiteColor;
        _valueLabel.shadowColor = kSQColorDefaultBlackColor;
        _valueLabel.shadowOffset = CGSizeMake(0, 1);
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.adjustsFontSizeToFitWidth = YES;
        _valueLabel.numberOfLines = 1;
        [self addSubview:_valueLabel];
        
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = kSQDefaultSecondaryBoldFont;
        _unitLabel.textColor = kSQColorDefaultWhiteColor;
        _unitLabel.shadowColor = kSQColorDefaultBlackColor;
        _unitLabel.shadowOffset = CGSizeMake(0, 1);
        _unitLabel.backgroundColor = [UIColor clearColor];
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.adjustsFontSizeToFitWidth = YES;
        _unitLabel.numberOfLines = 1;
        [self addSubview:_unitLabel];
    }
    return self;
}

#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize valueLabelSize = CGSizeZero;
    valueLabelSize = [self.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:self.valueLabel.font}];
    
    CGSize unitLabelSize = CGSizeZero;
    unitLabelSize = [self.unitLabel.text sizeWithAttributes:@{NSFontAttributeName:self.unitLabel.font}];

    CGFloat xOffset = ceil((self.bounds.size.width - (valueLabelSize.width + unitLabelSize.width)) * 0.5);
    
    self.valueLabel.frame = CGRectMake(xOffset, ceil(self.bounds.size.height * 0.5) - ceil(valueLabelSize.height * 0.5), valueLabelSize.width, valueLabelSize.height);
    self.unitLabel.frame = CGRectMake(CGRectGetMaxX(self.valueLabel.frame), ceil(self.bounds.size.height * 0.5) - ceil(unitLabelSize.height * 0.5) + kSQChartValueViewPadding + 3, unitLabelSize.width, unitLabelSize.height);
}

@end
