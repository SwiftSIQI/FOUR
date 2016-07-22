//
//  NSDateComponents+SQNSDateComponentsExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (SQNSDateComponentsExtension)

+ (NSDateComponents *)sq_getDefaultDateComponentsFormNow;
+ (NSDateComponents *)sq_getDefaultDateComponentsFormDate:(NSDate *)date;


@end
