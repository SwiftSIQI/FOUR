//
//  SQChartInformationView.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/2.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQChartInformationView : UIView

- (id)initWithFrame:(CGRect)frame;

// Content
- (void)setTitleText:(NSString *)titleText;
- (void)setValueText:(NSString *)valueText unitText:(NSString *)unitText;

// Color
- (void)setTitleTextColor:(UIColor *)titleTextColor;
- (void)setValueAndUnitTextColor:(UIColor *)valueAndUnitColor;
- (void)setTextShadowColor:(UIColor *)shadowColor;
- (void)setSeparatorColor:(UIColor *)separatorColor;

// Visibility
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

//设置字体大小
- (void)setTextFontOfValueLabelInValueView:(UIFont *)font;
- (void)setTextFontOfUnitLabelInValueView:(UIFont *)font;

@end
