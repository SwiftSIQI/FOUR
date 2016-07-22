//
//  AppDelegate.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/20.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <PKRevealing>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = kSQColorDefaultBackgroundBlackColor;
    
    //读取CurrentVersion
    BOOL isNewVersion = [self isNewVersion];
    isNewVersion ? [self showWelcomeViewController] : [self showDefaultViewController];
        
    //令window课件
    [self.window makeKeyAndVisible];
    
    //监听WelcomeViewController发出的切换根控制的通知
    [[NSNotificationCenter defaultCenter] addObserverForName:kSQChangeDefaultVCNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [self showDefaultViewController];
        
    }];
    
    /***************************************************************/
    if(![IAPShare sharedHelper].iap) {
        
        NSSet* dataSet = [[NSSet alloc] initWithObjects:@"com.SQFantasyStudio.rmb6", @"com.SQFantasyStudio.rmb18", @"com.SQFantasyStudio.rmb45", @"com.SQFantasyStudio.rmb98", nil];
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
        
    }
    
    [IAPShare sharedHelper].iap.production = NO;

    
    /***************************************************************/
    setenv("XcodeColors", "YES", 0);
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    [DDTTYLogger sharedInstance].logFormatter = [[SQCustomFormatter alloc] init];
    /***************************************************************/
    return YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)isNewVersion{
    //获取当前app的版本号
    NSString *newVersion =  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    //加载沙盒中的版本号记录
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentVersionKey];
    //写入新的版本号
    [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:kCurrentVersionKey];

    return newVersion > currentVersion;
}

- (void)showDefaultViewController{
    //设置KeyWindow的根控制器
    //左边的控制器
    SQLeftMenuViewController *leftMenuViewController = [[SQLeftMenuViewController alloc] init];
    //右边的控制器
    SQRightMenuViewController *rightMenuViewController = [[SQRightMenuViewController alloc] init];
    //Navi的根控制器
    SQHomeViewController *homeVC = [[SQHomeViewController alloc] init];
    //中间的控制器
    SQNavigationController *navigationController = [[SQNavigationController alloc] initWithRootViewController:homeVC];
    //window的根控制器
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navigationController leftViewController:leftMenuViewController rightViewController:rightMenuViewController];
    //注意在.h文件中遵守协议
    revealController.delegate = self;
    //设置根控制器
    self.window.rootViewController = revealController;
}


- (void)showWelcomeViewController{
    //创建欢迎界面
    SQWelcomeViewController *welcomeVC = [[SQWelcomeViewController alloc] init];
    //设置根控制器
    self.window.rootViewController = welcomeVC;
}

@end
