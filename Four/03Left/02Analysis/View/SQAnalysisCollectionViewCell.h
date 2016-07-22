//
//  SQAnalysisCollectionViewCell.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SQLineChartType){
    SQEveryDayInWeekChart = 0,
    SQEveryWeekInMonthChart = 1,
    SQEveryMonthInYearChart = 2
};


@interface SQAnalysisCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) SQLineChartType type;

@end
