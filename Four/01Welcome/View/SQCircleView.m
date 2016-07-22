//
//  SQCircleView.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/12.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQCircleView.h"

@interface SQCircleView()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation SQCircleView

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.maskLayer) {
        self.maskLayer = [CAShapeLayer layer];
        self.layer.mask = self.maskLayer;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetWidth(self.bounds) / 2.f];
    self.maskLayer.path = path.CGPath;    
    self.layer.cornerRadius = CGRectGetWidth(self.layer.bounds) / 2.f;
}

@end
