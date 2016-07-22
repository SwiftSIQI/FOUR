//
//  NSNumber+SQNSNumberExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSNumber+SQNSNumberExtension.h"

@implementation NSNumber (SQNSNumberExtension)

- (NSNumber *)sq_getNumberByPlusTimeIntervalFromDate:(NSDate *)date{
    
    NSTimeInterval timeIntervalNew = [date timeIntervalSince1970];
    
    double timeIntervalOld = self.doubleValue;
    
    double timeTotalDouble = (timeIntervalOld + timeIntervalNew) ;
    
    NSNumber *timeTotal = [NSNumber numberWithDouble:timeTotalDouble];
    
    return timeTotal;
}

- (NSNumber *)sq_conversionUnitFromSecondsToHours{

    double numberOfDouble = self.doubleValue;
    numberOfDouble = numberOfDouble / 3600;
    return [NSNumber numberWithDouble:numberOfDouble];

}

@end
