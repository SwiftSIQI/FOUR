//
//  SQTaskDetailsRealmModel.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/24.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Realm/Realm.h>

@interface SQTaskDetailsRealmModel : RLMObject

@property NSString *ID;
@property NSString *taskColor;
@property NSString *taskName;
@property NSDate *creatTime;
@property NSDate *executeTime;

+ (NSArray *)getAllTaskDataInRecentSevenDays;
+ (NSArray *)getAllTaskDataInRecentSevenWeeks;
+ (NSArray *)getAllTaskDataInRecentSevenMonth;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<SQTaskDetailsRealmModel>
RLM_ARRAY_TYPE(SQTaskDetailsRealmModel)
