//
//  SQHistoryTableViewCell.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHistoryTableViewCell.h"

@interface SQHistoryTableViewCell ()

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *executeTimeLabel;
@property (nonatomic, strong) UILabel *createTimeLable;
@property (nonatomic, strong) UIView *separaterView;

@end

@implementation SQHistoryTableViewCell
#pragma mark - 重写set方法
- (void)setIndex:(NSInteger)index{
    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"NO.%ld",index + 1];
}

- (void)setTaskDetailsModel:(SQTaskDetailsRealmModel *)taskDetailsModel{
    _taskDetailsModel = taskDetailsModel;
    NSString *createTimeString = [[NSDateFormatter sq_defaultFullFormatter] stringFromDate:taskDetailsModel.creatTime];
    self.createTimeLable.text = [NSString stringWithFormat:@"Create at %@", createTimeString];
    NSString *executeTimeString = [NSString sq_getExecutedTimeStringbyTimeInterval:[taskDetailsModel.executeTime timeIntervalSince1970]];
    self.executeTimeLabel.text = [NSString stringWithFormat:@"Execute Time is %@", executeTimeString];
}

#pragma mark - 懒加载
- (UILabel *)indexLabel{
    if (_indexLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentLeft];
        _indexLabel = label;
    }
    return _indexLabel;
}

- (UILabel *)executeTimeLabel{
    if (_executeTimeLabel == nil) {
        UILabel *label = [UILabel sq_tertiaryLabelWithColor:kSQColorDefaultPrimaryTextBlackColor textAlignment:NSTextAlignmentRight];
        _executeTimeLabel = label;
    }
    return _executeTimeLabel;
}

- (UILabel *)createTimeLable{
    if (_createTimeLable == nil) {
        UILabel *label = [UILabel sq_tertiaryLabelWithColor:kSQColorDefaultSecondaryTextBlackColor textAlignment:NSTextAlignmentRight];
        _createTimeLable = label;
    }
    return _createTimeLable;
}

- (UIView *)separaterView{
    if (_separaterView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSQColorDefaultGreyColor;
        _separaterView = view;
    }
    return _separaterView;
}

#pragma mark - alloc/init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.indexLabel];
        [self.contentView addSubview:self.executeTimeLabel];
        [self.contentView addSubview:self.createTimeLable];
        [self.contentView addSubview:self.separaterView];
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
    
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kSmallMargin);
        make.bottom.equalTo(self.createTimeLable.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(kSmallMargin);
        make.width.equalTo(@110);
    }];
    
    [self.executeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.indexLabel.mas_right).offset(kSmallMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-kSmallMargin);
        make.top.equalTo(self.contentView.mas_top).offset(kSmallMargin);
    }];
    
    [self.createTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.executeTimeLabel.mas_left);
        make.right.equalTo(self.executeTimeLabel.mas_right);
        make.top.equalTo(self.executeTimeLabel.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kSmallMargin);
    }];
    
    [self.separaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(1));
    }];
}

#pragma mark - 响应方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
