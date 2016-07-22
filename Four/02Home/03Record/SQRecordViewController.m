//
//  SQRecordViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/23.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQRecordViewController.h"

@interface SQRecordViewController ()

@property (nonatomic, strong) UILabel *taskNameLabel;
@property (nonatomic, strong) UIButton *timeRecordButton;
@property (nonatomic, strong) UIImageView *circleView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) STPopupController *infoViewController;
//单位是秒
@property (nonatomic, assign) NSInteger executeTimeInSecond;
//计时器
@property (nonatomic, strong) NSTimer *timer;
//计时状态
@property (nonatomic, assign) BOOL isTiming;

@end

@implementation SQRecordViewController
#pragma mark - 重写set方法
- (void)setTaskModel:(SQTaskRealmModel *)taskModel{
    _taskModel = taskModel;
    self.taskNameLabel.text = taskModel.taskName;
    
    UIColor *color = [UIColor sq_getDefalutColorByStringName:taskModel.taskColor];
    [self.saveButton setBackgroundColor:color];
}


#pragma mark - 懒加载
- (UILabel *)taskNameLabel{
    if (_taskNameLabel == nil) {
        UILabel *label = [UILabel sq_primaryLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentCenter];
        _taskNameLabel = label;
    }
    return _taskNameLabel;
}

- (UIButton *)timeRecordButton{
    if(_timeRecordButton == nil){
        UIButton *button = [UIButton sq_defaultButtonWithBackgroundColor:[UIColor clearColor] titleString: @"00:00:00"];
        button.titleLabel.font = kSQDefaultFontBoldWith(55);
        [button addTarget:self action:@selector(recordTime:) forControlEvents:UIControlEventTouchUpInside];
        _timeRecordButton = button;
    }
    return _timeRecordButton;
}

- (UIImageView *)circleView{
    if (_circleView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"circleView"];
        _circleView = imageView;
    }
    return _circleView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        UIView *view = [[UIView alloc] init];
        _bottomView = view;
    }
    return _bottomView;
}

- (UIButton *)resetButton{
    if (_resetButton == nil) {
        UIButton *button = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultGreyColor titleString: @"RESET"];
        [button addTarget:self action:@selector(resetTime) forControlEvents:UIControlEventTouchUpInside];
        _resetButton = button;
    }
    return _resetButton;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        UIButton *button = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultGreyColor titleString: @"SAVE"];
        [button addTarget:self action:@selector(saveTaskDetailRealmModel:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton = button;
    }
    return _saveButton;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimeButtonInfo) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    self.isTiming = NO;
    self.executeTimeInSecond = 0;
    [self setupUI];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self.timer invalidate];
    self.timer = nil;
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 布局相关
- (void)setupUI{
    [self.view addSubview:self.taskNameLabel];
    [self.view addSubview:self.circleView];
    [self.view addSubview:self.timeRecordButton];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.resetButton];
    [self.bottomView addSubview:self.saveButton];
    
    [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
    }];
    
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskNameLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.taskNameLabel.mas_left);
        make.width.equalTo(@(kScreenWidht - 2 * kInsertMargin));
        make.height.equalTo(@(kScreenWidht - 2 * kInsertMargin));
    }];
    
    [self.timeRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleView.mas_centerX);
        make.centerY.equalTo(self.circleView.mas_centerY);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.taskNameLabel.mas_left);
        make.right.equalTo(self.taskNameLabel.mas_right);
    }];
    
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.width.equalTo(@(8 * kLargeMargin));
        make.height.equalTo(@(4 * kLargeMargin));
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView.mas_right);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.width.equalTo(@(8 * kLargeMargin));
        make.height.equalTo(@(4 * kLargeMargin));
    }];
}


#pragma mark - 监听方法
- (void)updateTimeButtonInfo{
    self.executeTimeInSecond += 1;
    //计算新的执行时间
    NSString *newexecuteTimeInSecond = [NSString sq_getExecutedTimeStringbyTimeInterval:self.executeTimeInSecond];
    [self.timeRecordButton setTitle:newexecuteTimeInSecond forState:UIControlStateNormal];
}

- (void)recordTime:(UIButton *)button{
    if (self.isTiming == YES){
        self.isTiming = NO;
        [self.timer setFireDate:[NSDate distantFuture]];
        //恢复自动锁屏功能
        [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
    }else if (self.isTiming == NO){
        self.isTiming = YES;
        [self.timer setFireDate:[NSDate distantPast]];
        //禁止自动锁屏功能
        [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    }
}

- (void)resetTime{
    self.isTiming = NO;
    self.executeTimeInSecond = 0;
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timeRecordButton setTitle:@"00:00:00" forState:UIControlStateNormal];
    //恢复自动锁屏功能
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
}

- (void)saveTaskDetailRealmModel:(UIButton *)button{
    //恢复自动锁屏功能
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
    //停止计时
    [self.timer setFireDate:[NSDate distantFuture]];
    //如果没有开始计时,就提醒用户计时后再保存
    if ([[self.timeRecordButton currentTitle] isEqualToString:@"00:00:00"]) {
        [self showErrorHUD];
        return;
    }
    //创建此次执行的时间对象
    NSDate *executeDate = [NSDate dateWithTimeIntervalSince1970:self.executeTimeInSecond];
    //获取之前执行的总时间对象和时间间隔
    RLMResults<SQTaskRealmModel *> *taskModelGroup = [SQTaskRealmModel objectsWhere:@"taskColor = %@",self.taskModel.taskColor];
    NSDate *totalDate = taskModelGroup.lastObject.timeTotal;
    NSTimeInterval totalInterval = [totalDate timeIntervalSince1970];
    //计算新的总执行时间
    NSDate *newTotal = [NSDate dateWithTimeIntervalSince1970:totalInterval + self.executeTimeInSecond];
    //记录数据
    SQTaskDetailsRealmModel *taskDetailModel = [[SQTaskDetailsRealmModel alloc] init];
    taskDetailModel.ID = [[NSUUID UUID] UUIDString];
    taskDetailModel.taskColor = self.taskModel.taskColor;
    taskDetailModel.taskName = self.taskModel.taskName;
    taskDetailModel.creatTime = [NSDate date];
    taskDetailModel.executeTime = executeDate;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //记载数据
    [realm addObject:taskDetailModel];
    //更新总时间
    //更新taskModel
    [SQTaskRealmModel createOrUpdateInDefaultRealmWithValue:@{
            @"taskColor": self.taskModel.taskColor,
            @"timeTotal": newTotal
    }];
    [realm commitWriteTransaction];
    //弹出对话框
    [self showSuccessHUD];
}


- (void)showSuccessHUD{
    //创建弹出框
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:@"Success" contentString:@"Your task is successfully recorded!" contentSize:CGSizeMake(kScreenWidht * 0.75, 120) rightBarButtonTitle:nil];
    
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];
    self.infoViewController = popupController;
    
    popupController.hidesCloseButton = YES;
    
    //点击backgroundView自动消失
    [popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap)]];
    
    [popupController presentInViewController:self];
}

- (void)showErrorHUD{
    //创建弹出框
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:@"OOPS" contentString:@"Task time can't be zero,Tap the timer!" contentSize:CGSizeMake(kScreenWidht * 0.75, 120) rightBarButtonTitle:@"nil"];
    
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];
    self.infoViewController = popupController;
    
    //点击backgroundView自动消失
    [popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap)]];
    
    [popupController presentInViewController:self];
}

- (void)backgroundViewDidTap{
    [self.infoViewController dismissWithCompletion:^{
        [self resetTime];
        //如果存储时,执行时间已经大于10000小时,就发送通知
        if ([NSDate sq_isLargerThan10KHours:self.taskModel.timeTotal]) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            self.taskModel.isAchieve = YES;
            [realm commitWriteTransaction];
            //发送通知
            NSDictionary *userInfo = @{@"taskColor": self.taskModel.taskColor};
            [[NSNotificationCenter defaultCenter] postNotificationName:kSQAchieveTaskNotification object:nil userInfo:userInfo];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
