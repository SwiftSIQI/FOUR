//
//  SQHomeCollectionCell.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/22.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHomeCollectionCell.h"

@interface SQHomeCollectionCell ()
//任务按钮
@property (nonatomic, strong) UIButton *taskButton;
//任务说明
@property (nonatomic, strong) UILabel *taskLabel;
//用于显示ArchieveLogo
@property (nonatomic, strong) UIImageView *achieveImageView;
//弹出框
@property (nonatomic, strong) STPopupController *popupController;

@end

@implementation SQHomeCollectionCell
#pragma mark - 重写set方法
- (void)setTaskModel:(SQTaskRealmModel *)taskModel{
    //赋值
    _taskModel = taskModel;
    //自定义操作
    if(taskModel.isCreate == YES) {
        NSString *createdImageName = [taskModel.taskColor stringByAppendingString:@"_created"];
        [self.taskButton setImage:[UIImage imageNamed:createdImageName] forState:UIControlStateNormal];
        self.taskLabel.text = taskModel.taskName;
    }else {
        NSString *uncreatedImageName = [taskModel.taskColor stringByAppendingString:@"_uncreated"];
        [self.taskButton setImage:[UIImage imageNamed:uncreatedImageName] forState:UIControlStateNormal];
        self.taskLabel.text = nil;
    }
    
    if (taskModel.isAchieve == YES) {
        self.achieveImageView.hidden = NO;
        self.taskButton.hidden = YES;
    } else{
        self.achieveImageView.hidden = YES;
        self.taskButton.hidden = NO;
    }
}

#pragma mark - 懒加载
- (UIButton *)taskButton{
    if (_taskButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button addTarget:self action:@selector(taskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _taskButton = button;
    }
    return _taskButton;
}

- (UILabel *)taskLabel{
    if (_taskLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentCenter];
        _taskLabel = label;
    }
    return _taskLabel;
}



- (UIImageView *)achieveImageView{
    if (_achieveImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"achieve_cell"];
        imageView.hidden = YES;
        _achieveImageView = imageView;
    }
    return _achieveImageView;
}


#pragma mark - Alloc/Init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSQColorDefaultBackgroundBlackColor;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.achieveImageView];
        [self.contentView addSubview:self.taskButton];
        [self.contentView addSubview:self.taskLabel];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressActivated)];
        longPress.minimumPressDuration = 1.0;
        [self.contentView addGestureRecognizer:longPress];
                
        //监听删除任务的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteTaskModelAndTaskDetailModel:) name:kSQDeleteTaskNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.taskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(self.contentView.bounds.size.height * kTaskButtonHeightRatio));
    }];
    
    [self.taskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taskButton.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(kTaskLabelHeightRatio);
    }];
    
    [self.achieveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(self.contentView.bounds.size.height * kTaskButtonHeightRatio));
    }];
}

#pragma mark - 响应方法
- (void)deleteTaskModelAndTaskDetailModel:(NSNotification *)notification{
    NSString *taskColor = notification.userInfo[@"taskColor"];
        
    if (taskColor == self.taskModel.taskColor) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        /*******删除taskDetailModel*********/
        RLMResults<SQTaskDetailsRealmModel *> *result = [SQTaskDetailsRealmModel objectsWhere:@"taskColor = %@", self.taskModel.taskColor];
        [realm deleteObjects:result];
        /*******删除taskModel*********/
        //更新taskRealmModel
        self.taskModel.taskName = @"";
        self.taskModel.isCreate = NO;
        self.taskModel.isAchieve = NO;
        self.taskModel.timeTotal = [NSDate dateWithTimeIntervalSince1970:0];
        //该步骤是为了调用self.taskModel的set方法,用于更新cell的UI
        self.taskModel = self.taskModel;
        
        [realm commitWriteTransaction];
    }
}

- (void)taskButtonClick:(UIButton *)button{
    NSDictionary *userInfo = @{
                               @"taskRealmModel" : self.taskModel
                               };
    [[NSNotificationCenter defaultCenter] postNotificationName:kSQShowTaskVCNotification object:self userInfo:userInfo];
}

- (void)longPressActivated{
    //如果任务没有创建,就不执行下面的代码
    if (self.taskModel.isCreate == NO) {
        return;
    }
    
    //创建弹出框的根控制器
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:@"Want to Delete?" contentString:@"This operation will delete all records of the task, Do you want to continue?" contentSize:CGSizeMake(kPopupViewWidth, kPopupDefaulViewtHeight) rightBarButtonTitle:@"Next"];
    //传递数据模型,便于后面进行删除操作
    alertVC.taskColor = self.taskModel.taskColor;
    //创建弹出框
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];;
    //实现点击backgroundView后,弹出框自动消失
    [popupController.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap)]];
    self.popupController = popupController;
    
    //如果有任务创建,长按就会激活删除任务界面
    PKRevealController *rootVC = (PKRevealController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    SQNavigationController *navigationController = (SQNavigationController *)rootVC.frontViewController;
    UIViewController *topVC = navigationController.topViewController;
    [self.popupController presentInViewController:topVC];
}

- (void)backgroundViewDidTap{
    [self.popupController dismiss];
}
@end
