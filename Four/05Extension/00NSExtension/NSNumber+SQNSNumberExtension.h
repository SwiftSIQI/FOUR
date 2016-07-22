//
//  NSNumber+SQNSNumberExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SQNSNumberExtension)

- (NSNumber *)sq_getNumberByPlusTimeIntervalFromDate:(NSDate *)date;
- (NSNumber *)sq_conversionUnitFromSecondsToHours;
@end
