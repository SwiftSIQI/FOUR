//
//  SQOverviewTableViewCell.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/14.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQOverviewTableViewCell.h"

@interface SQOverviewTableViewCell()

@property (nonatomic, strong) UILabel *mainLabel;

@end

@implementation SQOverviewTableViewCell

#pragma mark - 重写TaskRealmModel的set方法
- (void)setTaskRealmModel:(SQTaskRealmModel *)taskRealmModel{
    _taskRealmModel = taskRealmModel;
    self.mainLabel.text = taskRealmModel.taskName;
    self.backgroundColor = [UIColor sq_getDefalutColorByStringName:taskRealmModel.taskColor];
}

#pragma mark - 懒加载
- (UILabel *)mainLabel{
    if (_mainLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        label.font = kSQDefaultPrimaryFont;
        label.textAlignment = NSTextAlignmentCenter;
        _mainLabel = label;
    }
    return _mainLabel;
}

#pragma mark - alloc/init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.mainLabel];
    }
    return self;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 布局方法
- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsMake(1,1,1,1);
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
@end
