//
//  SQDeveloperTableViewCell.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/19.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQDeveloperTableViewCell.h"

@interface SQDeveloperTableViewCell ()


@end

@implementation SQDeveloperTableViewCell

#pragma mark - 懒加载
- (UIImageView *)portraitImageView{
    if (_portraitImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        _portraitImageView = imageView;
    }
    return _portraitImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [UILabel sq_secondaryBoldLabelWithColor:kSQColorDefaultPrimaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)infoLabel{
    if (_infoLabel == nil) {
        UILabel *label = nil;
        if([UIDevice sq_isScreenFitFor4_0Inch] == YES){
            label = [UILabel sq_labelWithDefaultRegularFontSize:10 Color:kSQColorDefaultSecondaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        }else{
            label = [UILabel sq_tertiaryLabelWithColor:kSQColorDefaultSecondaryTextWhiteColor textAlignment:NSTextAlignmentLeft];
        }
        _infoLabel = label;
    }
    return _infoLabel;
}


#pragma mark - alloc/init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.portraitImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.infoLabel];
    }
    return self;
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 重写选中状态的方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 布局方法
- (void)layoutSubviews{
    [super layoutSubviews];

    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kLargeMargin);
        make.left.equalTo(self.contentView.mas_left).offset(kInsertMargin);
        make.width.and.height.equalTo(@(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.portraitImageView.mas_top);
        make.bottom.equalTo(self.portraitImageView.mas_bottom);
        make.left.equalTo(self.portraitImageView.mas_right).offset(kLargeMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-kInsertMargin);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.portraitImageView.mas_bottom).offset(kSmallMargin);
        make.left.equalTo(self.portraitImageView.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kLargeMargin);
    }];
    
}

@end
