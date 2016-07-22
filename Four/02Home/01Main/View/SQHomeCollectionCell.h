//
//  SQHomeCollectionCell.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/22.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQTaskRealmModel;

@interface SQHomeCollectionCell : UICollectionViewCell

//cell的数据模型
@property (nonatomic, strong) SQTaskRealmModel *taskModel;

@end
