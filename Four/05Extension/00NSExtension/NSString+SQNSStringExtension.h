//
//  NSString+SQNSStringExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQNSStringExtension)

+ (NSString *)sq_getStringOfRecentSevenDays;
+ (NSString *)sq_getStringOfRecentSevenWeeks;
+ (NSString *)sq_getStringOfRecentSevenMonths;

+ (NSString *)sq_getExecutedTimeStringbyTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString *)sq_getStringbySQDefaultFormatterWithDate:(NSDate *)date;



@end
