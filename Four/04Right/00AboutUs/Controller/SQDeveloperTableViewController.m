//
//  SQDeveloperTableViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/6.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQDeveloperTableViewController.h"

@interface SQDeveloperTableViewController ()

@property (nonatomic, strong) NSArray *developerInfo;

@end

@implementation SQDeveloperTableViewController
#pragma mark - 懒加载
- (NSArray *)developerInfo{
    if (_developerInfo == nil) {
        NSArray *array = @[
            @{
                @"name": @"SketchK",
                @"info": @"红魔曼联的超级拥痞\n手速达不到180的废柴鼓手\n做的一手白日梦的理想主义家\n目前是一名iOS开发者\n\n江湖人称\"七叔\",其实就是一个奇葩\n立志成为像达芬奇爷爷 鲁迅先生一样的杂家\n年少时期 开朗和善 \n后不知是情路坎坷还是吃错东西\n性格大变 火速变身腹黑怪蜀黍 \n虽屡被劝阻要积口德\n但谁叫咱是腹黑摩羯座呢...",
                @"imageName": @"portrait_sketchk"
            },
            @{
                @"name": @"13hun",
                @"info": @"平淡的度过了自己20多年的人生\n励志做队友背后的女人\n我是个爱画画的处女座\n\n时常在否定中重新认识自己\n时常感恩生活中的温柔\n想要跑一次马拉松 想要蹦一次极\n愿为身边的人带来欢乐\n眼下一心要做好的事情\nAngular 2 \n你啥时候能出正式版?",
                @"imageName": @"portrait_13hun"
            }
            ];
        
        _developerInfo = array;
    }
    return _developerInfo;
}

#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];

    self.tableView.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQDeveloperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfDevTableViewCell];
    
    if (cell == nil) {
        cell = [[SQDeveloperTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kIdentifierOfDevTableViewCell];
        cell.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    }
    
    NSDictionary *dict = self.developerInfo[indexPath.row];
    
    cell.nameLabel.text = dict[@"name"];
    cell.infoLabel.text = dict[@"info"];
    cell.portraitImageView.image = [UIImage imageNamed:dict[@"imageName"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kScreenHeight - kStatusBarHeight - kNavigationBarHeight) * 0.5;
}

@end
