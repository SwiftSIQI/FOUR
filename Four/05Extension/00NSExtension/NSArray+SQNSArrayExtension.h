//
//  NSArray+SQNSArrayExtension.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SQNSArrayExtension)

+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenDays;
+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenWeeks;
+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenMonths;

+ (NSArray *)sq_getArrayOfDefaultColorString;
+ (NSArray *)sq_getArrayOfDefaultColor;
+ (NSArray *)sq_getArrayOfCreatedTaskColor;
+ (NSArray *)sq_getArrayOfCreatedTaskColorString;
+ (NSArray *)sq_getArrayOfProductIdentifierString;
@end
