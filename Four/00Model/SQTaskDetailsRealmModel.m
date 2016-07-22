//
//  SQTaskDetailsRealmModel.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/24.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQTaskDetailsRealmModel.h"

@implementation SQTaskDetailsRealmModel

+ (NSString *)primaryKey{
    return @"ID";
}

#pragma mark - 返回指定数据的方法
+ (NSArray *)getAllTaskDataInRecentSevenDays{
    //获取当天的日期信息(利用NSCalendarUnit)
    NSDateComponents *componentsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];
    
    //获取颜色数组
    NSArray *taskColorNameArray = [NSArray sq_getArrayOfCreatedTaskColorString];
    
    //创建一个数组用于保存本周的信息
    //数据格式如下,外部数组用于传递给chartDate,内部数组表示每周的数据
    //外部数组(内部数组1, 内部数组2)
    NSMutableArray *allLineChartData = [NSMutableArray array];
    
    for (int i = 0; i < taskColorNameArray.count; i ++) {
        //获取某个类型数据的集合(不同颜色)
        RLMResults <SQTaskDetailsRealmModel *> *result = [SQTaskDetailsRealmModel objectsWhere:@"taskColor = %@", taskColorNameArray[i]];
        
        NSMutableArray <NSNumber *> *singleLineChartData = [NSMutableArray array];
        
        //初始化数组,保证数组中的初始值为0
        for (int i = 0; i < kLineChartViewMaxNumChartPoints; i++) {
            [singleLineChartData addObject:@(0)];
        }
        
        //从数据库返回的数据中筛选出本周的日期
        for (int i =  0; i < result.count ; i++) {
            
            SQTaskDetailsRealmModel *detailTaskModel = result[i];
            NSDateComponents *componentsRecord = [NSDateComponents sq_getDefaultDateComponentsFormDate:detailTaskModel.creatTime];
            
            if (componentsNow.weekOfYear == componentsRecord.weekOfYear){
                //说明当前日期是本周内发生的记录
                switch (componentsRecord.weekday) {
                    case 1:{
                        singleLineChartData[0] = [singleLineChartData[0] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 2:{
                        singleLineChartData[1] = [singleLineChartData[1] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 3:{
                        singleLineChartData[2] = [singleLineChartData[2] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 4:{
                        singleLineChartData[3] = [singleLineChartData[3] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 5:{
                        singleLineChartData[4] = [singleLineChartData[4] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 6:{
                        singleLineChartData[5] = [singleLineChartData[5] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    case 7:{
                        singleLineChartData[6] = [singleLineChartData[6] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                        break;
                    }
                    default:
                        break;
                }
            }
        }
        
        //注意:由于直接计算小时的话,会由于计时时间段,造成小数点后面的数据精度丢失,因此数组里保存秒,到最后累积完毕后,再转换为小时
        for (int i = 0; i < singleLineChartData.count; i++) {
            singleLineChartData[i] = [singleLineChartData[i] sq_conversionUnitFromSecondsToHours];
        }
        [allLineChartData addObject:singleLineChartData];
    }
    return allLineChartData;
}


+ (NSArray *)getAllTaskDataInRecentSevenWeeks{
    //获取当天的日期信息(利用NSCalendarUnit)
    NSDateComponents *componentsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];
    
    //获取颜色数组
    NSArray *taskColorNameArray = [NSArray sq_getArrayOfCreatedTaskColorString];
    
    //获取当前周在本年度的序号
    NSInteger weekOfYear = componentsNow.weekOfYear;
    
    //创建一个数组用于保存本周的信息
    //数据格式如下,外部数组用于传递给chartDate,内部数组表示每周的数据
    //外部数组(内部数组1, 内部数组2)
    NSMutableArray *allLineChartData = [NSMutableArray array];
    
    for (int i = 0; i < taskColorNameArray.count; i ++) {
        
        //获取某个类型数据的集合(不同颜色)
        RLMResults <SQTaskDetailsRealmModel *> *result = [SQTaskDetailsRealmModel objectsWhere:@"taskColor = %@", taskColorNameArray[i]];
        
        NSMutableArray <NSNumber *> *singleLineChartData = [NSMutableArray array];
        
        //初始化数组,保证数组中的初始值为0
        for (int i = 0; i < kLineChartViewMaxNumChartPoints; i++) {
            [singleLineChartData addObject:@(0)];
        }
        
        //从数据库返回的数据中筛选出近7周的日期
        for (int i =  0; i < result.count ; i++) {
            //获取数据库中第i个元素的components2
            SQTaskDetailsRealmModel *detailTaskModel = result[i];
            NSDateComponents *componentsRecord = [NSDateComponents sq_getDefaultDateComponentsFormDate:detailTaskModel.creatTime];
            
            //判断编号的范围
            if (weekOfYear <= 7) {
                //如果是当年的前七周,就显示当年的前七周
                if (componentsRecord.weekOfYear == 1) {
                    singleLineChartData[0] = [singleLineChartData[0] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 2){
                    singleLineChartData[1] = [singleLineChartData[1] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 3){
                    singleLineChartData[2] = [singleLineChartData[2] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 4){
                    singleLineChartData[3] = [singleLineChartData[3] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 5){
                    singleLineChartData[4] = [singleLineChartData[4] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 6){
                    singleLineChartData[5] = [singleLineChartData[5] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == 7){
                    singleLineChartData[6] = [singleLineChartData[6] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }
            } else {
                //如果是年中的任意七周,就显示这七周
                if (componentsRecord.weekOfYear == (weekOfYear - 6)) {
                    //说明当前是倒数第七周
                    singleLineChartData[0] = [singleLineChartData[0] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == (weekOfYear - 5)){
                    singleLineChartData[1] = [singleLineChartData[1] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == (weekOfYear - 4)){
                    singleLineChartData[2] = [singleLineChartData[2] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == (weekOfYear - 3)){
                    singleLineChartData[3] = [singleLineChartData[3] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == (weekOfYear - 2)){
                    singleLineChartData[4] = [singleLineChartData[4] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == (weekOfYear - 1)){
                    singleLineChartData[5] = [singleLineChartData[5] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.weekOfYear == weekOfYear ){
                    singleLineChartData[6] = [singleLineChartData[6] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }
            }
        }
        
        for (int i = 0; i < singleLineChartData.count; i++) {
            singleLineChartData[i] = [singleLineChartData[i] sq_conversionUnitFromSecondsToHours];
        }
        [allLineChartData addObject:singleLineChartData];
    }
    return allLineChartData;
}



+ (NSArray *)getAllTaskDataInRecentSevenMonth{
    //获取当天的日期信息(利用NSCalendarUnit)
    NSDateComponents *componentsNow = [NSDateComponents sq_getDefaultDateComponentsFormNow];
    //获取颜色数组
    NSArray *taskColorNameArray = [NSArray sq_getArrayOfCreatedTaskColorString];
    //获取当前月在本年度的序号
    NSInteger month = componentsNow.month;
    
    //创建一个数组用于保存本周的信息
    //数据格式如下,外部数组用于传递给chartDate,内部数组表示每周的数据
    //外部数组(内部数组1, 内部数组2)
    NSMutableArray *allLineChartData = [NSMutableArray array];
    
    for (int i = 0; i < taskColorNameArray.count; i ++) {
        //获取某个类型数据的集合(不同颜色)
        RLMResults <SQTaskDetailsRealmModel *> *result = [SQTaskDetailsRealmModel objectsWhere:@"taskColor = %@", taskColorNameArray[i]];
        NSMutableArray <NSNumber *> *singleLineChartData = [NSMutableArray array];
        
        //初始化数组,保证数组中的初始值为0
        for (int i = 0; i < kLineChartViewMaxNumChartPoints; i++) {
            [singleLineChartData addObject:@(0)];
        }
        
        //从数据库返回的数据中筛选出近7周的日期
        for (int i =  0; i < result.count ; i++) {
            //获取数据库中第i个元素的components2
            SQTaskDetailsRealmModel *detailTaskModel = result[i];
            NSDateComponents *componentsRecord = [NSDateComponents sq_getDefaultDateComponentsFormDate:detailTaskModel.creatTime];
            
            //判断编号的范围
            if (month <= 7) {
                if (componentsRecord.month == 1) {
                    singleLineChartData[0] = [singleLineChartData[0] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 2){
                    singleLineChartData[1] = [singleLineChartData[1] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 3){
                    singleLineChartData[2] = [singleLineChartData[2] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 4){
                    singleLineChartData[3] = [singleLineChartData[3] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 5){
                    singleLineChartData[4] = [singleLineChartData[4] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 6){
                    singleLineChartData[5] = [singleLineChartData[5] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == 7){
                    singleLineChartData[6] = [singleLineChartData[6] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }
            } else {
                if (componentsRecord.month == (month - 6)) {
                    singleLineChartData[0] = [singleLineChartData[0] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == (month - 5)){
                    singleLineChartData[1] = [singleLineChartData[1] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == (month - 4)){
                    singleLineChartData[2] = [singleLineChartData[2] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == (month - 3)){
                    singleLineChartData[3] = [singleLineChartData[3] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == (month - 2)){
                    singleLineChartData[4] = [singleLineChartData[4] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == (month - 1)){
                    singleLineChartData[5] = [singleLineChartData[5] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }else if (componentsRecord.month == month ){
                    singleLineChartData[6] = [singleLineChartData[6] sq_getNumberByPlusTimeIntervalFromDate:detailTaskModel.executeTime];
                }
            }
        }
        
        for (int i = 0; i < singleLineChartData.count; i++) {
            singleLineChartData[i] = [singleLineChartData[i] sq_conversionUnitFromSecondsToHours];
        }
        
        [allLineChartData addObject:singleLineChartData];
    }    
    return allLineChartData;
}

@end
