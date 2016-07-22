//
//  UIDevice+SQUIDeviceExtension.h
//  Four
//
//  Created by 张思琦 on 16/7/20.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (SQUIDeviceExtension)

+ (NSString *)sq_platform;
+ (NSString *)sq_platformString;

+ (BOOL)sq_isScreenFitFor5_5Inch;
+ (BOOL)sq_isScreenFitFor4_7Inch;
+ (BOOL)sq_isScreenFitFor4_0Inch;

@end
