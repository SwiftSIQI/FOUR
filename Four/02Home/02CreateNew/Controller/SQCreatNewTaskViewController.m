//
//  SQCreatNewTaskViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/22.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQCreatNewTaskViewController.h"

@interface SQCreatNewTaskViewController ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) SQTextField *taskNameTextField;
@property (nonatomic, strong) SQTextField *hoursTextField;
@property (nonatomic, strong) SQTextField *minutesTextField;

@property (nonatomic, strong) UILabel *taskNameLabel;
@property (nonatomic, strong) UILabel *introduceLable;
@property (nonatomic, strong) UILabel *hoursLabel;
@property (nonatomic, strong) UILabel *minutesLabel;


@property (nonatomic, strong) STPopupController *infoViewController;

@end

@implementation SQCreatNewTaskViewController
#pragma mark - 重写set方法
- (void)setTaskModel:(SQTaskRealmModel *)taskModel{
    _taskModel = taskModel;
    UIColor *color = [UIColor sq_getDefalutColorByStringName:taskModel.taskColor];
    [self.addButton setBackgroundColor:color];
}


#pragma mark - 懒加载
- (UIButton *)addButton{
    if (_addButton == nil) {
        UIButton *addButton = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultGreyColor titleString: @"Add"];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addButton = addButton;
    }
    return _addButton;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        UIButton *cancleButton = [UIButton sq_defaultButtonWithBackgroundColor:kSQColorDefaultGreyColor titleString: @"Cancel"];
        [cancleButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = cancleButton;

    }
    return _cancelButton;
}

- (UILabel *)taskNameLabel{
    if (_taskNameLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"New Task Name";
        _taskNameLabel = label;
    }
    return _taskNameLabel;
}

- (UILabel *)introduceLable{
    if (_introduceLable == nil ) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"I already started:";
        _introduceLable = label;
    }
    return _introduceLable;
}

- (UILabel *)hoursLabel{
    if (_hoursLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultRegularFontSize:18 Color:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"hours";
        _hoursLabel = label;
    }
    return _hoursLabel;
}

- (UILabel *)minutesLabel{
    if (_minutesLabel == nil) {
        UILabel *label = [UILabel sq_labelWithDefaultRegularFontSize:18 Color:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        label.text = @"minutes";
        _minutesLabel = label;
    }
    return _minutesLabel;
}

- (SQTextField *)taskNameTextField{
    if (_taskNameTextField == nil) {
        SQTextField *textField = [[SQTextField alloc] init];
        textField.placeholder = @"Put Your TaskName";
        _taskNameTextField = textField;
    }
    return _taskNameTextField;
}

- (SQTextField *)hoursTextField{
    if (_hoursTextField == nil) {
        SQTextField *textField = [[SQTextField alloc] init];
        textField.placeholder = @"0~10000";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _hoursTextField = textField;
    }
    return _hoursTextField;
}


- (SQTextField *)minutesTextField{
    if (_minutesTextField == nil) {
        SQTextField *textField = [[SQTextField alloc] init];
        textField.placeholder = @"0~60";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _minutesTextField= textField;
    }
    return _minutesTextField;
}



#pragma mark - 监听方法
- (void)cancelButtonClick{
    //取消键盘的第一响应者
    [self.taskNameTextField resignFirstResponder];
    [self.hoursTextField resignFirstResponder];
    [self.minutesTextField resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addButtonClick{
    //判断输入的数据是否有效
    NSInteger hours = self.hoursTextField.text.integerValue;
    NSInteger minutes = self.minutesTextField.text.integerValue;
    
    BOOL hoursIsCorrect = (hours >= 0 && hours <= 10000 && self.hoursTextField.text.length <= 5)? YES : NO;
    
    BOOL minutesIsCorrect = (minutes >= 0 && minutes < 60 && self.minutesTextField.text.length <= 2)? YES : NO;
    
    BOOL taskNameIsCorrect = (self.taskNameTextField.text.length > 0) ? YES : NO;

    if ( hoursIsCorrect && minutesIsCorrect && taskNameIsCorrect ){
        //输入正确,创建数据库
        
        //创建taskDetailsModel表格数据
        SQTaskDetailsRealmModel *taskDetailModel = [[SQTaskDetailsRealmModel alloc] init];
        //获取任务颜色
        taskDetailModel.ID = [[NSUUID UUID] UUIDString];
        taskDetailModel.taskColor = self.taskModel.taskColor;
        //获取任务名称
        taskDetailModel.taskName = self.taskNameTextField.text;
        //获取任务创建时间
        taskDetailModel.creatTime = [NSDate date];
        taskDetailModel.executeTime = [NSDate dateWithTimeIntervalSince1970:(hours * 60 * 60 + minutes * 60)];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        //添加表格数据
        //更新taskModel
        self.taskModel.taskName = self.taskNameTextField.text;
        self.taskModel.isCreate = YES;
        self.taskModel.timeTotal = [NSDate dateWithTimeIntervalSince1970:(hours * 60 * 60 + minutes * 60)];
        //添加detailsTaskModel
        //如果执行时间不为0,就存储taskDetailModel
        if (![taskDetailModel.executeTime isEqualToDate:[NSDate dateWithTimeIntervalSince1970:0]]) {
            [realm addObject:taskDetailModel];
        }
        [realm commitWriteTransaction];

        //发送创建任务的通知,便于History中的数据进行更新
        [[NSNotificationCenter defaultCenter] postNotificationName:kSQCreateTaskNotification object:self userInfo:nil];
    
        [self showSuccessHUD];
    }else {
        //如果输入的参数有错误,就进入此代码块
        //修改输入错误的文本框中的内容
        if(hoursIsCorrect == NO) {
            self.hoursTextField.text = nil;
        }
        if(minutesIsCorrect == NO){
            self.minutesTextField.text = nil;
        }
        if (taskNameIsCorrect == NO) {
            self.taskNameTextField.text = nil;
        }
        //弹出提示框
        [self showErrorHUD];
    }
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - 布局方法
- (void)setupUI{
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.cancelButton];
    
    [self.view addSubview:self.taskNameLabel];
    [self.view addSubview:self.introduceLable];
    [self.view addSubview:self.hoursLabel];
    [self.view addSubview:self.minutesLabel];
    
    [self.view addSubview:self.taskNameTextField];
    [self.view addSubview:self.hoursTextField];
    [self.view addSubview:self.minutesTextField];
    
    [self.taskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset( kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view.mas_left).offset(kInsertMargin);
        make.right.equalTo(self.view.mas_right).offset(-kInsertMargin);
    }];
    
    [self.taskNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskNameLabel.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.taskNameLabel.mas_left);
        make.right.equalTo(self.taskNameLabel.mas_right);
    }];
    
    [self.introduceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskNameTextField.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.taskNameLabel.mas_left);
        make.right.equalTo(self.taskNameLabel.mas_right);
    }];
    
    [self.hoursTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLable.mas_bottom).offset(kLargeMargin);
        make.left.equalTo(self.taskNameLabel.mas_left);
    }];
    
    [self.hoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hoursTextField.mas_top);
        make.left.equalTo(self.hoursTextField.mas_right).offset(kSmallMargin);
        make.bottom.equalTo(self.hoursTextField.mas_bottom);
    }];
    
    [self.minutesTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hoursTextField.mas_top);
        make.left.equalTo(self.hoursLabel.mas_right).offset(kSmallMargin);
       make.width.equalTo(self.hoursTextField.mas_width);
    }];
    
    [self.minutesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hoursTextField.mas_top);
        make.left.equalTo(self.minutesTextField.mas_right).offset(kSmallMargin);
        make.right.equalTo(self.taskNameLabel.mas_right);
        make.bottom.equalTo(self.hoursTextField.mas_bottom);
    }];

    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hoursTextField.mas_bottom).offset(2 *kLargeMargin);
        make.left.equalTo(self.taskNameLabel.mas_left);
        make.width.equalTo(@(8 * kLargeMargin));
        make.height.equalTo(@(4 * kLargeMargin));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelButton.mas_top);
        make.right.equalTo(self.taskNameLabel.mas_right);
        make.width.equalTo(@(8 * kLargeMargin));
        make.height.equalTo(@(4 * kLargeMargin));
    }];
}

- (void)showSuccessHUD{
    //创建弹出框
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:@"Success" contentString:@"Your Task Is Successfully Created!" contentSize:CGSizeMake(kPopupViewWidth, kPopupDefaulViewtHeight) rightBarButtonTitle:nil];
    
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];
    self.infoViewController = popupController;
    
    popupController.hidesCloseButton = YES;
    //添加点击backgroundView自动消失的手势
    [popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap)]];
    
    [popupController presentInViewController:self];
}

- (void)showErrorHUD{
    //创建弹出框
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:@"Error" contentString:@"Your task is not created!\nPlease check again" contentSize:CGSizeMake(kPopupViewWidth, kPopupDefaulViewtHeight) rightBarButtonTitle:nil];
    
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];
    self.infoViewController = popupController;
    
    //添加点击backgroundView自动消失的手势
    [popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap)]];
    
    [popupController presentInViewController:self];
}

- (void)backgroundViewDidTap{
    [self.infoViewController dismissWithCompletion:^{
        if(self.infoViewController.hidesCloseButton == YES){
            //说明当前是成功界面
            [self cancelButtonClick];
            //如果存储时,执行时间已经大于10000小时,就发送通知
            if ([NSDate sq_isLargerThan10KHours:self.taskModel.timeTotal]) {
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                self.taskModel.isAchieve = YES;
                [realm commitWriteTransaction];
                NSDictionary *userInfo = @{@"taskColor": self.taskModel.taskColor};
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kSQAchieveTaskNotification object:nil userInfo:userInfo];
            }
        }
    }];
}

@end
