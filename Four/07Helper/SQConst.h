//
//  SQConst.h
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/5.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通用设置
 */
//App的状态栏高度
UIKIT_EXTERN CGFloat const kStatusBarHeight;
//App的Nav栏高度
UIKIT_EXTERN CGFloat const kNavigationBarHeight;
UIKIT_EXTERN CGFloat const kNaviTitleViewHeight;
UIKIT_EXTERN CGFloat const kNaviTitleViewWidth;
//App的Nav中,Icon的宽高
UIKIT_EXTERN CGFloat const kNavigationBarIconHeight;
UIKIT_EXTERN CGFloat const kNavigationBarIconWeight;
//App中,常用边距
UIKIT_EXTERN CGFloat const kSmallMargin;
UIKIT_EXTERN CGFloat const kMiddleMargin;
UIKIT_EXTERN CGFloat const kLargeMargin;
UIKIT_EXTERN CGFloat const kInsertMargin;
//Button默认的参数
UIKIT_EXTERN CGFloat const kButtonFontSize;
UIKIT_EXTERN CGFloat const kButtonCornerRadius;
//Popup的默认参数
UIKIT_EXTERN CGFloat const kPopupCornerRadius;
/**
 *  左右侧边栏
 */
//App的左右侧边栏中cell的高度
UIKIT_EXTERN CGFloat const kSideMenuCellHeight;
//App的左右侧边栏中cell的个数
UIKIT_EXTERN CGFloat const kLeftSideMenuCellNumber;
UIKIT_EXTERN CGFloat const kRightSideMenuCellNumber;
/**
 *  主界面
 */
//主界面中CollectionView中各个控件的高度比例
//主界面中CollectionView的cell中各个控件的高度比例
UIKIT_EXTERN CGFloat const kTaskButtonHeightRatio;
UIKIT_EXTERN CGFloat const kTaskLabelHeightRatio;
UIKIT_EXTERN CGFloat const kAddSymbolImageViewRatio;
//主界面中CollectionView的cell中"+"和"Add"与中心点的偏移量
UIKIT_EXTERN CGFloat const kAddSymbolImageViewOffsetY;
UIKIT_EXTERN CGFloat const kAddCharacterLabelOffsetY;
/**
 *  创建任务界面
 */
//SQTextView的相关参数
UIKIT_EXTERN CGFloat const kTextViewCornerRadius;


/**
 *  History界面的设置
 */
//在History界面中,TitleView的高度
UIKIT_EXTERN CGFloat const kTableViewTitleViewHeight;

/**
 *  Analysis界面的设置
 */
//在Analysis界面中,图表的种类
UIKIT_EXTERN CGFloat const kChartTypeNumber;
UIKIT_EXTERN CGFloat const kLineChartViewMaxNumChartPoints;

//LineChart的相关设定
//图表高度
UIKIT_EXTERN CGFloat const kSQLineChartViewChartHeight;
//图表头部高度
UIKIT_EXTERN CGFloat const kSQLineChartViewChartHeaderHeight;
//图标头部内边距
UIKIT_EXTERN CGFloat const kSQLineChartViewChartHeaderPadding;

//图表底部高度
UIKIT_EXTERN CGFloat const kSQLineChartViewChartFooterHeight;
//图表实线线宽
UIKIT_EXTERN CGFloat const kSQLineChartViewChartSolidLineWidth;
//图表圆点半径
UIKIT_EXTERN CGFloat const kSQLineChartViewChartDotRadius;

//TooltipView的动画时间间隔
UIKIT_EXTERN CGFloat const kSQBaseChartViewAnimationDuration;

//TooltipView的相关设定
UIKIT_EXTERN CGFloat const kSQChartTooltipViewCornerRadius;
UIKIT_EXTERN CGFloat const kSQChartTooltipViewDefaultWidth;
UIKIT_EXTERN CGFloat const kSQChartTooltipViewDefaultHeight;

//TooltipTipView的相关设定
UIKIT_EXTERN CGFloat const kSQChartTooltipTipViewDefaultWidth;
UIKIT_EXTERN CGFloat const kSQChartTooltipTipViewDefaultHeight;

//LineChart中Header的相关设定
UIKIT_EXTERN CGFloat const kSQChartHeaderViewPadding;
UIKIT_EXTERN CGFloat const kSQChartHeaderViewSeparatorHeight;

//LineChart中Footer的相关设定
UIKIT_EXTERN CGFloat const kSQLineChartFooterViewSeparatorWidth;
UIKIT_EXTERN CGFloat const kSQLineChartFooterViewSeparatorHeight;
UIKIT_EXTERN CGFloat const kSQLineChartFooterViewSeparatorSectionPadding;

//InformationView的相关设定
UIKIT_EXTERN CGFloat const kSQChartValueViewPadding;
UIKIT_EXTERN CGFloat const kSQChartValueViewSeparatorSize;
UIKIT_EXTERN CGFloat const kSQChartValueViewTitleHeight;
UIKIT_EXTERN CGFloat const kSQChartValueViewTitleWidth;
UIKIT_EXTERN CGFloat const kSQChartValueViewDefaultAnimationDuration;

/**
 *  AboutUs界面相关
 */
UIKIT_EXTERN CGFloat const kAboutUsCellHeight ;
UIKIT_EXTERN CGFloat const kAboutUsCellNumber;
UIKIT_EXTERN CGFloat const kAboutUsCellFontSize;

/**
 *  Pods界面相关
 */
UIKIT_EXTERN CGFloat const kPodsManiCellHeight;
UIKIT_EXTERN CGFloat const kPodsDefaultCellHeight;

/**
 *  通知
 */
UIKIT_EXTERN NSString * const kSQShowTaskVCNotification;
UIKIT_EXTERN NSString * const kSQCreateTaskNotification;
UIKIT_EXTERN NSString * const kSQChangeDefaultVCNotification;
UIKIT_EXTERN NSString * const kSQAchieveTaskNotification;
UIKIT_EXTERN NSString * const kSQDeleteTaskNotification;
UIKIT_EXTERN NSString * const kSQSelectedOverviewCellNotification;

/**
 *  标识符
 */
//CollectionViewCell
UIKIT_EXTERN NSString * const kIdentifierOfHomeCollectionCell;
UIKIT_EXTERN NSString * const kIdentifierOfAnalysisCollectionViewCell;

//TableViewCell
UIKIT_EXTERN NSString * const kIdentifierOfLeftMenuTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfRightMenuTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfOverviewTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfHistoryTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfAboutUsTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOf10KHOURSTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfPodsTableViewCell;
UIKIT_EXTERN NSString * const kIdentifierOfDevTableViewCell;

/**
 *  记录版本号的Key键名称
 */
UIKIT_EXTERN NSString * const kCurrentVersionKey;
/**
 *  记录AppID的名称
 */
UIKIT_EXTERN NSString * const kAppID;





