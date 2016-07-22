//
//  NSDateComponents+SQNSDateComponentsExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSDateComponents+SQNSDateComponentsExtension.h"

@implementation NSDateComponents (SQNSDateComponentsExtension)

+ (NSDateComponents *)sq_getDefaultDateComponentsFormNow{

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    
    return [calendar components:unit fromDate:now];
}

+ (NSDateComponents *)sq_getDefaultDateComponentsFormDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    return [calendar components:unit fromDate:date];

}




@end
