//
//  SQAnalysisCollectionViewCell.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAnalysisCollectionViewCell.h"

@interface SQAnalysisCollectionViewCell() <JBLineChartViewDelegate, JBLineChartViewDataSource>

//自定义contentView
@property (nonatomic, strong) UIView *customContentView;

//线框图
@property (nonatomic, strong) JBLineChartView *lineChartView;
//信息图
@property (nonatomic, strong) SQChartInformationView *informationView;

//JBLineChartView上显示的白色浮动框
@property (nonatomic, strong) SQChartTooltipView *tooltipView;
@property (nonatomic, strong) SQChartTooltipTipView *tooltipTipView;
@property (nonatomic, assign) BOOL tooltipVisible;

//数据
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *unitOfTime;

//颜色数组
@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation SQAnalysisCollectionViewCell
#pragma mark - 重写type的set方法
- (void)setType:(SQLineChartType)type{
    _type = type;
    
    switch (type) {
        case SQEveryDayInWeekChart: {
            //获取数据
            self.chartData = [SQTaskDetailsRealmModel getAllTaskDataInRecentSevenDays];
            self.unitOfTime = [NSArray sq_getTimeUnitArrayOfRecentSevenDays];
            
            //设置headrView的标题
            SQChartHeaderView *headerViewOfLineChartView = (SQChartHeaderView *)self.lineChartView.headerView;
            headerViewOfLineChartView.titleLabel.text = @"Recent 7 Days";
            headerViewOfLineChartView.subtitleLabel.text = [NSString sq_getStringOfRecentSevenDays];
            //设置footerView的标题
            SQChartFooterView *footerViewOfLineChartView = (SQChartFooterView *)self.lineChartView.footerView;
            footerViewOfLineChartView.leftLabel.text = [[self.unitOfTime firstObject] uppercaseString];
            footerViewOfLineChartView.rightLabel.text = [[self.unitOfTime lastObject] uppercaseString];
            footerViewOfLineChartView.sectionCount = [[self largestLineData] count];
            
            //刷新数据
            [self.lineChartView reloadData];
            [self.lineChartView setState:JBChartViewStateExpanded];

            break;
        }
        case SQEveryWeekInMonthChart: {
            //获取数据
            self.chartData = [SQTaskDetailsRealmModel getAllTaskDataInRecentSevenWeeks];
            self.unitOfTime = [NSArray sq_getTimeUnitArrayOfRecentSevenWeeks];
            
            //设置headrView的标题
            SQChartHeaderView *headerViewOfLineChartView = (SQChartHeaderView *)self.lineChartView.headerView;
            headerViewOfLineChartView.titleLabel.text = @"Recent 7 Weeks";
            headerViewOfLineChartView.subtitleLabel.text = [NSString sq_getStringOfRecentSevenWeeks];
            //设置footerView的标题
            SQChartFooterView *footerViewOfLineChartView = (SQChartFooterView *)self.lineChartView.footerView;
            footerViewOfLineChartView.leftLabel.text = [[self.unitOfTime firstObject] uppercaseString];
            footerViewOfLineChartView.rightLabel.text = [[self.unitOfTime lastObject] uppercaseString];
            footerViewOfLineChartView.sectionCount = [[self largestLineData] count];
            
            //刷新数据
            [self.lineChartView reloadData];
            [self.lineChartView setState:JBChartViewStateExpanded];
            
            break;
        }
        case SQEveryMonthInYearChart: {
            //获取数据
            self.chartData = [SQTaskDetailsRealmModel getAllTaskDataInRecentSevenMonth];
            self.unitOfTime = [NSArray sq_getTimeUnitArrayOfRecentSevenMonths];
            
            //设置headrView的标题
            SQChartHeaderView *headerViewOfLineChartView = (SQChartHeaderView *)self.lineChartView.headerView;
            headerViewOfLineChartView.titleLabel.text = @"Recent 7 Months";
            headerViewOfLineChartView.subtitleLabel.text = [NSString sq_getStringOfRecentSevenMonths];
            //设置footerView的标题
            SQChartFooterView *footerViewOfLineChartView = (SQChartFooterView *)self.lineChartView.footerView;
            footerViewOfLineChartView.leftLabel.text = [[self.unitOfTime firstObject] uppercaseString];
            footerViewOfLineChartView.rightLabel.text = [[self.unitOfTime lastObject] uppercaseString];
            footerViewOfLineChartView.sectionCount = [[self largestLineData] count];
            
            //刷新数据
            [self.lineChartView reloadData];
            [self.lineChartView setState:JBChartViewStateExpanded];
            
            break;
        }
    }
}

#pragma mark - Data
- (NSArray *)largestLineData{
    NSArray *largestLineData = nil;
    for (NSArray *lineData in self.chartData){
        if ([lineData count] > [largestLineData count]){
            largestLineData = lineData;
        }
    }
    return largestLineData;
}

#pragma mark - 懒加载
- (UIView *)customContentView{
    if (_customContentView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultPopupBlackColor;
        _customContentView = view;
    }
    return _customContentView;
}

- (JBLineChartView *)lineChartView{
    if (_lineChartView == nil) {
        JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
        lineChartView.frame = CGRectMake(kMiddleMargin, kLargeMargin, kCollectonCellCustomContentViewWidth - 2 * kMiddleMargin , kSQLineChartViewChartHeight);
        lineChartView.delegate = self;
        lineChartView.dataSource = self;
        
        lineChartView.headerPadding = kSQLineChartViewChartHeaderPadding;
        lineChartView.backgroundColor = self.backgroundColor;
        
        SQChartHeaderView *headerView = [[SQChartHeaderView alloc] initWithFrame:CGRectMake( kMiddleMargin, ceil(kCollectonCellCustomContentViewHeight * 0.5) - ceil(kSQLineChartViewChartHeaderHeight * 0.5), kCollectonCellCustomContentViewWidth - 2 * kMiddleMargin, kSQLineChartViewChartHeaderHeight)];
        headerView.titleLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        headerView.titleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        headerView.titleLabel.shadowOffset = CGSizeMake(0, 1);
        
        headerView.subtitleLabel.textColor = kSQColorDefaultSecondaryTextWhiteColor;
        headerView.subtitleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        headerView.subtitleLabel.shadowOffset = CGSizeMake(0, 1);
        headerView.separatorColor = kSQColorDefaultTertiaryTextWhiteColor ;
        
        SQChartFooterView *footerView = [[SQChartFooterView alloc] initWithFrame:CGRectMake(kMiddleMargin, ceil(kCollectonCellCustomContentViewHeight * 0.5) - ceil(kSQLineChartViewChartFooterHeight * 0.5), kCollectonCellCustomContentViewWidth - 2 * kMiddleMargin, kSQLineChartViewChartFooterHeight)];
        
        footerView.backgroundColor = [UIColor clearColor];
        footerView.leftLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        footerView.rightLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        
        lineChartView.headerView = headerView;
        lineChartView.footerView = footerView;
               
        _lineChartView = lineChartView;
    }
    return _lineChartView;
}

- (SQChartInformationView *)informationView{
    if (_informationView == nil) {
        SQChartInformationView *informationView = [[SQChartInformationView alloc] initWithFrame:CGRectMake(0, kSQLineChartViewChartHeight, kCollectonCellCustomContentViewWidth, kCollectonCellCustomContentViewHeight - kSQLineChartViewChartHeight - kLargeMargin)];
        
        informationView.backgroundColor = self.backgroundColor;
        [informationView setTitleTextColor:kSQColorDefaultPrimaryTextWhiteColor];
        [informationView setTextShadowColor:nil];
        [informationView setSeparatorColor:kSQColorDefaultPrimaryTextWhiteColor];
        
        _informationView = informationView;
    }
    return _informationView;
}

- (NSArray *)colorArray{
    return [NSArray sq_getArrayOfCreatedTaskColor];
}

#pragma mark - Alloc/Init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.customContentView.layer.cornerRadius = 15;
        self.customContentView.layer.shadowRadius = 22;
        self.customContentView.layer.shadowOpacity = 0.8;
        self.customContentView.layer.shadowOffset = CGSizeMake(8, 8);
        self.customContentView.layer.shadowColor = kSQColorDefaultBlackColor.CGColor;
        
        [self.contentView addSubview:self.customContentView];
        [self.customContentView addSubview:self.lineChartView];
        [self.customContentView addSubview:self.informationView];
    }
    return self;
}

- (void)dealloc{
    _lineChartView.delegate = nil;
    _lineChartView.dataSource = nil;
}

#pragma mark - 布局方法
- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsMake( 2 * kLargeMargin, 2 * kLargeMargin, 2 * kLargeMargin, 2 * kLargeMargin);
    [self.customContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}

#pragma mark - 浮动框相关方法
- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated atTouchPoint:(CGPoint)touchPoint{
    _tooltipVisible = tooltipVisible;
    
    JBChartView *chartView = self.lineChartView;
    
    if (!chartView){
        return;
    }
    
    if (!self.tooltipView){
        self.tooltipView = [[SQChartTooltipView alloc] init];
        self.tooltipView.alpha = 0.0;
        [self addSubview:self.tooltipView];
    }
    
    [self bringSubviewToFront:self.tooltipView];
    
    if (!self.tooltipTipView){
        self.tooltipTipView = [[SQChartTooltipTipView alloc] init];
        self.tooltipTipView.alpha = 0.0;
        [self addSubview:self.tooltipTipView];
    }
    
    [self bringSubviewToFront:self.tooltipTipView];
    
    dispatch_block_t adjustTooltipPosition = ^{
        
        CGPoint originalTouchPoint = [self convertPoint:touchPoint fromView:chartView];
        CGPoint convertedTouchPoint = originalTouchPoint; // modified
        JBChartView *chartView = self.lineChartView;
        if (chartView && !CGPointEqualToPoint(touchPoint, CGPointZero)){
            CGFloat minChartX = (chartView.frame.origin.x + ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x < minChartX){
                convertedTouchPoint.x = minChartX;
            }
            CGFloat maxChartX = (chartView.frame.origin.x + chartView.frame.size.width - ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x > maxChartX){
                convertedTouchPoint.x = maxChartX;
            }
            
            self.tooltipView.frame = CGRectMake(convertedTouchPoint.x - ceil(self.tooltipView.frame.size.width * 0.5), CGRectGetMaxY(chartView.headerView.frame), self.tooltipView.frame.size.width, self.tooltipView.frame.size.height);
            
            CGFloat minTipX = (chartView.frame.origin.x + self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x < minTipX){
                originalTouchPoint.x = minTipX;
            }
            CGFloat maxTipX = (chartView.frame.origin.x + chartView.frame.size.width - self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x > maxTipX){
                originalTouchPoint.x = maxTipX;
            }
            self.tooltipTipView.frame = CGRectMake(originalTouchPoint.x - ceil(self.tooltipTipView.frame.size.width * 0.5), CGRectGetMaxY(self.tooltipView.frame), self.tooltipTipView.frame.size.width, self.tooltipTipView.frame.size.height);
        }
    };
    
    dispatch_block_t adjustTooltipVisibility = ^{
        self.tooltipView.alpha = _tooltipVisible ? 1.0 : 0.0;
        self.tooltipTipView.alpha = _tooltipVisible ? 1.0 : 0.0;
    };
    
    if (animated){
        if (tooltipVisible){
            adjustTooltipPosition();
        }
        
        [UIView animateWithDuration:kSQBaseChartViewAnimationDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            adjustTooltipVisibility();
        } completion:^(BOOL finished) {
            if (!tooltipVisible){
                adjustTooltipPosition();
            }
        }];
    }
    else{
        adjustTooltipPosition();
        adjustTooltipVisibility();
    }
}

- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated{
    [self setTooltipVisible:tooltipVisible animated:animated atTouchPoint:CGPointZero];
}

- (void)setTooltipVisible:(BOOL)tooltipVisible{
    [self setTooltipVisible:tooltipVisible animated:NO];
}

#pragma mark - JBLineChartViewDataSource
//chartView中的线条数量
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView{
    return [self.chartData count];
}

//chartView中线条上有效点的数量
- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex{
    return [[self.chartData objectAtIndex:lineIndex] count];
}

//在chartView上是否显示为光滑曲线
- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

//线条的颜色
- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex{
    
    return  self.colorArray[lineIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex{
    return self.colorArray[lineIndex];
}

//线条的宽度
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex{
    return  kSQLineChartViewChartSolidLineWidth;
}

#pragma mark - JBLineChartViewDelegate
//用于判断图表中第index点的value
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
    return [[[self.chartData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex] floatValue];
}

//用于判断点击图表中第index点后的操作
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint{
    
    NSNumber *valueNumber = [[self.chartData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex];
    [self.informationView setValueText:[NSString stringWithFormat:@"%.2f", [valueNumber floatValue]] unitText:@"h"];
    [self.informationView setTitleText:@"Executed Time is:"];
    [self.informationView setValueAndUnitTextColor:self.colorArray[lineIndex]];
    [self.informationView setHidden:NO animated:YES];
    [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
    [self.tooltipView setText:[[self.unitOfTime objectAtIndex:horizontalIndex] uppercaseString]];
}

//点击图表后的操作
- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView{
    [self.informationView setHidden:YES animated:YES];
    [self setTooltipVisible:NO animated:YES];
}


@end
