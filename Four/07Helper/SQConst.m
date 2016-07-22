//
//  SQConst.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/5.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQConst.h"
/**
 *  通用设置
 */
//App的状态栏高度
CGFloat const kStatusBarHeight = 20;
//App的Nav栏高度
CGFloat const kNavigationBarHeight = 44;
CGFloat const kNaviTitleViewWidth = 87;
CGFloat const kNaviTitleViewHeight = 24;
//App的Nav中,Icon的宽高
CGFloat const kNavigationBarIconHeight = 24;
CGFloat const kNavigationBarIconWeight = 24;
//App中,默认的边距
CGFloat const kSmallMargin = 5;
CGFloat const kMiddleMargin = 10;
CGFloat const kLargeMargin = 15;
CGFloat const kInsertMargin = 30;
//Button默认的参数
CGFloat const kButtonFontSize = 28;
CGFloat const kButtonCornerRadius = 5;
//Popup的默认参数
CGFloat const kPopupCornerRadius = 5;

/**
 *  左右侧边栏
 */
//App的左右侧边栏中cell的高度
CGFloat const kSideMenuCellHeight = 49;
//App的左右侧边栏中cell的个数
CGFloat const kLeftSideMenuCellNumber = 3;
CGFloat const kRightSideMenuCellNumber = 4;

/**
 *  主界面
 */
//主界面中CollectionView中各个控件的高度比例
//主界面中CollectionView的cell中各个控件的高度比例
CGFloat const kTaskButtonHeightRatio = 0.8;
CGFloat const kTaskLabelHeightRatio = 0.2;
CGFloat const kAddSymbolImageViewRatio = 0.15;
//主界面中CollectionView的cell中"+"和"Add"与中心点的偏移量
CGFloat const kAddSymbolImageViewOffsetY = -5;
CGFloat const kAddCharacterLabelOffsetY = 10;

/**
 *  创建任务界面
 */
CGFloat const kTextViewCornerRadius = 5;

/**
 *  记录任务界面
 */


/**
 *  History和Analysis界面的通用设置
 */
//在History和Analysis界面中,TitleView的高度
CGFloat const kTableViewTitleViewHeight = 35;


/**
 *  History界面的设置
 */


/**
 *  Analysis界面的设置
 */
//在Analysis界面中,图表的种类
CGFloat const kChartTypeNumber = 3;
CGFloat const kLineChartViewMaxNumChartPoints = 7;
//LineChart的相关设定
//图表高度
CGFloat const kSQLineChartViewChartHeight = 250.0f;
//图表头部高度
CGFloat const kSQLineChartViewChartHeaderHeight = 75.0f;
CGFloat const kSQLineChartViewChartHeaderPadding = 20.0f;
//图表底部高度
CGFloat const kSQLineChartViewChartFooterHeight = 20.0f;
//图表实线线宽
CGFloat const kSQLineChartViewChartSolidLineWidth = 5.5f;
//TooltipView的动画时间间隔
CGFloat const kSQBaseChartViewAnimationDuration = 0.1f;
//TooltipView的相关设定
CGFloat const kSQChartTooltipViewCornerRadius = 5.0;
CGFloat const kSQChartTooltipViewDefaultWidth = 50.0f;
CGFloat const kSQChartTooltipViewDefaultHeight = 25.0f;
//TooltipTipView的相关设定
CGFloat const kSQChartTooltipTipViewDefaultWidth = 8.0f;
CGFloat const kSQChartTooltipTipViewDefaultHeight = 5.0f;
//LineChart中Header的相关设定
CGFloat const kSQChartHeaderViewPadding = 10.0f;
CGFloat const kSQChartHeaderViewSeparatorHeight = 0.5f;
//LineChart中Footer的相关设定
CGFloat const kSQLineChartFooterViewSeparatorWidth = 0.5f;
CGFloat const kSQLineChartFooterViewSeparatorHeight = 3.0f;
CGFloat const kSQLineChartFooterViewSeparatorSectionPadding = 1.0f;
//InformationView的相关设定
CGFloat const kSQChartValueViewPadding = 10.0f;
CGFloat const kSQChartValueViewSeparatorSize = 0.5f;
CGFloat const kSQChartValueViewTitleHeight = 50.0f;
CGFloat const kSQChartValueViewTitleWidth = 75.0f;
CGFloat const kSQChartValueViewDefaultAnimationDuration = 0.25f;
/**
 *  AboutUS界面
 */
CGFloat const kAboutUsCellHeight = 80.0f;
CGFloat const kAboutUsCellNumber = 2.0f;
CGFloat const kAboutUsCellFontSize = 18.0f;

/**
 *  Pods界面相关
 */
CGFloat const kPodsManiCellHeight = 60.0f;
CGFloat const kPodsDefaultCellHeight = 40.0f;



/**
 *  通知
 */
NSString * const kSQShowTaskVCNotification = @"SQShowTaskVCNotification";
NSString * const kSQCreateTaskNotification = @"SQCreateTaskNotification";
NSString * const kSQChangeDefaultVCNotification = @"SQChangeDefaultNotification";
NSString * const kSQAchieveTaskNotification = @"SQAchieveTaskNotification";
NSString * const kSQDeleteTaskNotification = @"SQDeleteTaskNotification";
NSString * const kSQSelectedOverviewCellNotification = @"SQSelectedOverviewCellNotification";

/**
 *  标识符
 */
//CollectionViewCell
NSString * const kIdentifierOfHomeCollectionCell = @"HomeCell";
NSString * const kIdentifierOfAnalysisCollectionViewCell = @"AnalysisCell";
//TableViewCell
NSString * const kIdentifierOfLeftMenuTableViewCell = @"LeftMenuCell";
NSString * const kIdentifierOfRightMenuTableViewCell = @"RightMenuCell";
NSString * const kIdentifierOfOverviewTableViewCell = @"OverviewCell";
NSString * const kIdentifierOfHistoryTableViewCell = @"HistoryCell";
NSString * const kIdentifierOfAboutUsTableViewCell = @"AboutUsCell";
NSString * const kIdentifierOf10KHOURSTableViewCell = @"10KHOURSCell";
NSString * const kIdentifierOfPodsTableViewCell= @"PodsCell";
NSString * const kIdentifierOfDevTableViewCell = @"DevCell";

/**
 *  记录版本号的Key键名称
 */
NSString * const kCurrentVersionKey = @"CurrentVersion";
/**
 *  记录AppID的名称
 */
NSString * const kAppID = @"id1136588862";