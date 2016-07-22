//
//  SQChartFooterView.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/5.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQChartFooterView : UIView

@property (nonatomic, strong) UIColor *footerSeparatorColor; // footer separator (default = white)
@property (nonatomic, assign) NSInteger sectionCount; // # of notches (default = 2 on each edge)
@property (nonatomic, readonly) UILabel *leftLabel;
@property (nonatomic, readonly) UILabel *rightLabel;

@end
