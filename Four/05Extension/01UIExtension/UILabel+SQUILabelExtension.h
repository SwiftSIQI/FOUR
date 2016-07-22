//
//  UILabel+SQUILabelExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/18.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SQUILabelExtension)
//常用Label
+ (UILabel *)sq_primaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)sq_secondaryBoldLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)sq_secondaryRegularLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)sq_tertiaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;


//可以自定义大小的默认字体的Label
+ (UILabel *)sq_labelWithDefaultBoldFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)sq_labelWithDefaultRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)sq_longLabelWithRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment  linespacing:(CGFloat)linespacing string:(NSString *)string;



@end
