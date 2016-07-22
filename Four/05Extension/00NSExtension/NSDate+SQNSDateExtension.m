//
//  NSDate+SQNSDateExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSDate+SQNSDateExtension.h"

@implementation NSDate (SQNSDateExtension)

//- (NSDate *)sq_plusTimeintervalFromDate:(NSDate *)date{
//    
//    NSTimeInterval timeIntervalNew = [date timeIntervalSince1970];
//    NSTimeInterval timeIntervalOld = [self timeIntervalSince1970];
//    NSInteger timeTotal = timeIntervalNew + timeIntervalOld;
//    return [NSDate dateWithTimeIntervalSince1970:timeTotal];
//}


- (NSDate*)sq_startOfWeek {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] - ([components weekday] - 1))];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*)sq_endOfWeek {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] + (7 - [components weekday]))];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [gregorianCalendar dateFromComponents:components];
}

+ (BOOL)sq_isLargerThan10KHours:(NSDate *)date{
    NSTimeInterval maxTimeInterval = 10000 * 60 * 60;
    NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
    return (currentTimeInterval >= maxTimeInterval);
}


@end
