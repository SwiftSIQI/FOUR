//
//  SQHomeViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/21.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHomeViewController.h"

@interface SQHomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RLMResults *groupOfTaskRealmModel;

@end

@implementation SQHomeViewController
#pragma mark - 懒加载
//此处加载数据库文件
- (RLMResults *)groupOfTaskRealmModel{
    if(_groupOfTaskRealmModel == nil){
        //加载数据库文件
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults *result = nil;
        if (realm.isEmpty == YES){
            //初始化数据库
            NSArray *colorArray = [NSArray sq_getArrayOfDefaultColorString];
            //开启事务
            [realm beginWriteTransaction];
            //写入数据
            for (int i = 0; i < colorArray.count; i++) {
                SQTaskRealmModel *model = [[SQTaskRealmModel alloc] init];
                model.taskColor = colorArray[i];
                [realm addObject:model];
            }
            //提交事务
            [realm commitWriteTransaction];
            //读取数据
            result = [SQTaskRealmModel allObjects];
        }else if (realm.isEmpty == NO){
            //读取数据库中的数据
            result = [SQTaskRealmModel allObjects];
        }
        _groupOfTaskRealmModel = result;
    }
    return _groupOfTaskRealmModel;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        SQHomeCollectionLayout *layout = [[SQHomeCollectionLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kInsertMargin, 0, kScreenWidht - 2 * kInsertMargin, kScreenHeight - kStatusBarHeight - kNavigationBarHeight) collectionViewLayout:layout];
        collectionView.backgroundColor = kSQColorDefaultBackgroundBlackColor;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        _collectionView = collectionView;
    }
    return _collectionView;
    
}

#pragma mark - 生命周期相关
- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置view的背景色
    self.view.backgroundColor = kSQColorDefaultBackgroundBlackColor;

    //布局主界面中Navigation的控件
    [self setupNavigationItem];
    [self setupCollectionView];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTaskViewController:) name:kSQShowTaskVCNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showArchieveViewController:) name:kSQAchieveTaskNotification object:nil];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化布局
//设置导航栏相关
- (void)setupNavigationItem{
    self.navigationItem.titleView = [UIImageView sq_getDefaultTitleImageView];
    //设置navigationItem的leftButton
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"moreInfo"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    //设置navigationItem的rightButton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
}

//设置CollectionView相关
- (void)setupCollectionView{
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[SQHomeCollectionCell class] forCellWithReuseIdentifier:kIdentifierOfHomeCollectionCell];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SQHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifierOfHomeCollectionCell forIndexPath:indexPath];
    cell.taskModel = self.groupOfTaskRealmModel[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - 响应方法
- (void)showTaskViewController:(NSNotification *)notification{
    SQTaskRealmModel *taskRealmModel = notification.userInfo[@"taskRealmModel"];
    if (taskRealmModel.isCreate == YES) {
        SQRecordViewController *recordVC = [[SQRecordViewController alloc] init];
        recordVC.taskModel = taskRealmModel;
        [self.navigationController pushViewController:recordVC animated:YES];
    }else {
        SQCreatNewTaskViewController *creatNewTaskVC = [[SQCreatNewTaskViewController alloc] init];
        creatNewTaskVC.taskModel = taskRealmModel;
        [self presentViewController:creatNewTaskVC animated:YES completion:^{
        }];
    }
}

- (void)showArchieveViewController:(NSNotification *)notification{
    [self.collectionView reloadData];
    [self presentViewController:[[SQAchieveViewController alloc] init] animated:YES completion:nil];
}

- (void)presentLeftMenuViewController:(UIBarButtonItem *)leftBarButtonItem{
    
    PKRevealController *revealController = (PKRevealController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    [revealController showViewController:revealController.leftViewController animated:YES completion:^(BOOL finished) {
    }];
}

- (void)presentRightMenuViewController:(UIBarButtonItem *)rightBarButtonItem{
    PKRevealController *revealController = (PKRevealController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [revealController showViewController:revealController.rightViewController animated:YES completion:^(BOOL finished) {
    }];
}

@end
