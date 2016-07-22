//
//  SQTaskRealmModel.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/24.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQTaskRealmModel.h"

@implementation SQTaskRealmModel

#pragma mark - 配置主键
+ (NSString *)primaryKey{
    return @"taskColor";
}

// Specify default values for properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{
             @"taskName" : @"",
             @"taskColor" : @"NoColor",
             @"isCreate" : @NO,
             @"isAchieve" : @NO,
             @"timeTotal" : [NSDate dateWithTimeIntervalSince1970:0]
             };
}

@end
