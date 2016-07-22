//
//  NSDate+SQNSDateExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SQNSDateExtension)

//- (NSDate *)sq_plusTimeintervalFromDate:(NSDate *)date;

- (NSDate*)sq_startOfWeek;
- (NSDate*)sq_endOfWeek;
+ (BOOL)sq_isLargerThan10KHours:(NSDate *)date;


@end
