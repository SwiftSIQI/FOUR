//
//  NSDateFormatter+SQNSDateFormatterExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSDateFormatter+SQNSDateFormatterExtension.h"

@implementation NSDateFormatter (SQNSDateFormatterExtension)

//返回yyyy.MM.dd格式
+ (NSDateFormatter *)sq_defaultFormatter{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    formatter.timeZone = [NSTimeZone localTimeZone];    
    return formatter;
    
}

+ (NSDateFormatter *)sq_defaultFullFormatter{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return formatter;
    
}
@end
