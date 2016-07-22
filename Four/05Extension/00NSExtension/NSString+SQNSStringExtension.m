//
//  NSString+SQNSStringExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSString+SQNSStringExtension.h"

@implementation NSString (SQNSStringExtension)

+ (NSString *)sq_getStringOfRecentSevenDays{

    NSDateFormatter *formatter = [NSDateFormatter sq_defaultFormatter];
    
    NSDate *begin = [[NSDate date] sq_startOfWeek];
    NSDate *end = [[NSDate date] sq_endOfWeek];

    NSString *beginString = [formatter stringFromDate:begin];
    NSString *endString = [formatter stringFromDate:end];
    
    return [NSString stringWithFormat:@"%@  -  %@", beginString, endString];
}

+ (NSString *)sq_getStringOfRecentSevenWeeks{

    NSDateComponents *compsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];
    
    NSString *beginString = nil;
    NSString *endString = nil;
    
    if (compsNow.weekOfYear <= 7) {
        beginString = @"Week 1";
        endString = @"Week 7";
    }else{
        beginString = [NSString stringWithFormat:@"Week %ld", (compsNow.weekOfYear - 7)];
        endString = [NSString stringWithFormat:@"Week %ld", (long)compsNow.weekOfYear];
    }
    
    return [NSString stringWithFormat:@"%@  -  %@", beginString, endString];
}


+ (NSString *)sq_getStringOfRecentSevenMonths{
    NSDateComponents *compsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];

    NSString *beginString = nil;
    NSString *endString = nil;
    
    NSArray *monthArray = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    
    if (compsNow.month <= 7) {
        beginString = monthArray[0];
        endString = monthArray[6];
    }else{
        beginString = monthArray[compsNow.month - 7];
        endString = monthArray[compsNow.month - 1];
    }

    return [NSString stringWithFormat:@"%@  -  %@", beginString, endString];
}

+ (NSString *)sq_getExecutedTimeStringbyTimeInterval:(NSTimeInterval)timeInterval{

    NSInteger time = timeInterval;
    
    NSInteger seconds = time % 60;
    NSInteger minutes = ((time - seconds) / 60) % 60;
    NSInteger hours = ((time - seconds - 60 * minutes) / 3600) ;
    
    //计算新的执行时间
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

+ (NSString *)sq_getStringbySQDefaultFormatterWithDate:(NSDate *)date{

    NSDateFormatter *defaultFormatter = [NSDateFormatter sq_defaultFormatter];
    
    return [defaultFormatter stringFromDate:date];
    
}





@end
