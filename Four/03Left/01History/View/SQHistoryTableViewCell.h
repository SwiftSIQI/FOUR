//
//  SQHistoryTableViewCell.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQHistoryTableViewCell : UITableViewCell

@property (nonatomic, strong) SQTaskDetailsRealmModel *taskDetailsModel;
@property (nonatomic, assign) NSInteger index;

@end
