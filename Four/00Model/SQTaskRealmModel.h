//
//  SQTaskRealmModel.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/24.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Realm/Realm.h>

@interface SQTaskRealmModel : RLMObject

//任务的名称
@property NSString *taskName;
//任务的颜色
@property NSString *taskColor;
//任务是否被创建过
@property BOOL isCreate;
//任务是否达成
@property BOOL isAchieve;
//任务累计执行的总时间
@property NSDate *timeTotal;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<SQTaskRealmModel>
RLM_ARRAY_TYPE(SQTaskRealmModel)
