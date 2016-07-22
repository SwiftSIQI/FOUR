//
//  UILabel+SQUILabelExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/18.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "UILabel+SQUILabelExtension.h"

@implementation UILabel (SQUILabelExtension)

+ (UILabel *)sq_primaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultPrimaryFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;

    return label;
}

+ (UILabel *)sq_secondaryBoldLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultSecondaryBoldFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;

    return label;
}

+ (UILabel *)sq_secondaryRegularLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultSecondaryRegularFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}


+ (UILabel *)sq_tertiaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultTertiaryFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;

    return label;
}


+ (UILabel *)sq_labelWithDefaultBoldFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultFontBoldWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)sq_labelWithDefaultRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{

    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultFontRegularWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)sq_longLabelWithRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment  linespacing:(CGFloat)linespacing string:(NSString *)string{
    
    UILabel *label = [[UILabel alloc] init];
    label.font = kSQDefaultFontRegularWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;

    //根据String对象创建NSMutableAttributedString
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //设置段落间距的大小
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespacing];
    [paragraphStyle setAlignment:textAlignment];
    //对attributedString对象设置间距属性
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    
    //为label设置text
    [label setAttributedText:attributedString];
    
    return label;
}




@end
