//
//  NSArray+SQNSArrayExtension.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "NSArray+SQNSArrayExtension.h"

@implementation NSArray (SQNSArrayExtension)

+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenDays{
    return  [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
}


+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenWeeks{
    NSDateComponents *compsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];

    NSMutableArray *unitArray = [NSMutableArray array];
    
    if (compsNow.weekOfYear <= 7) {
        for (int i = 1 ; i <= 7 ; i++) {
            NSString *string = [NSString stringWithFormat:@"Week%02d", i];
            [unitArray addObject:string];
        }
    }else{
        for (int i = 6 ; i >= 0 ; i--) {
            NSString *string = [NSString stringWithFormat:@"Week%02ld", compsNow.weekOfYear - i];
            [unitArray addObject:string];
        }
    }
    return unitArray;
}

+ (NSArray *)sq_getTimeUnitArrayOfRecentSevenMonths{
    NSDateComponents *compsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];

    NSArray *monthArray = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];

    NSArray *unitArray = nil;
    
    if (compsNow.month <= 7) {
        NSRange range = NSMakeRange(0, 7);
        unitArray = [monthArray subarrayWithRange:range];
    }else{
        NSRange range = NSMakeRange(compsNow.month - 7, 7);
        unitArray = [monthArray subarrayWithRange:range];
    }

    return unitArray;
}

+ (NSArray *)sq_getArrayOfDefaultColorString{
    return  @[@"green", @"red", @"blue", @"yellow"];
}

+ (NSArray *)sq_getArrayOfDefaultColor{
    return  @[kSQColorDefaultGreenColor,kSQColorDefaultRedColor, kSQColorDefaultBlueColor, kSQColorDefaultYellowColor];
}


+ (NSArray *)sq_getArrayOfCreatedTaskColor{
    RLMResults *result = [SQTaskRealmModel objectsWhere:@"isCreate = YES"];
    NSMutableArray *array  = [[NSMutableArray alloc] init];
    for (SQTaskRealmModel *taskRealmModel in result) {
        UIColor *color = [UIColor sq_getDefalutColorByStringName:taskRealmModel.taskColor];
        [array addObject:color];
    }
    NSArray *colorArray = array;
    return colorArray;
}

+ (NSArray *)sq_getArrayOfCreatedTaskColorString{
    RLMResults *result = [SQTaskRealmModel objectsWhere:@"isCreate = YES"];
    NSMutableArray *array  = [[NSMutableArray alloc] init];
    for (SQTaskRealmModel *taskRealmModel in result) {
        [array addObject:taskRealmModel.taskColor];
    }
    NSArray *colorStringArray = array;
    return colorStringArray;
}

+ (NSArray *)sq_getArrayOfProductIdentifierString{
    return @[@"com.SQFantasyStudio.rmb6", @"com.SQFantasyStudio.rmb18", @"com.SQFantasyStudio.rmb45", @"com.SQFantasyStudio.rmb98"];
}


@end
