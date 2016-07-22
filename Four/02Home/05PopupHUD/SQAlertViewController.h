//
//  SQAlertViewController.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQAlertViewController : UIViewController

//为了删除功能预留的接口
@property (nonatomic, strong) NSString *taskColor;

- (instancetype)initWithTitleString:(NSString *)title contentString:(NSString *)content contentSize:(CGSize)size rightBarButtonTitle:(NSString *)titleName;


@end
