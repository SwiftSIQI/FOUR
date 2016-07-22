//
//  SQRightMenuViewController.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/21.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQRightMenuViewController.h"

@interface SQRightMenuViewController () <MFMailComposeViewControllerDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;

//@property (nonatomic, strong) STPopupController *infoViewController;

@end

@implementation SQRightMenuViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - kSideMenuCellHeight * kRightSideMenuCellNumber) / 2.0f, self.view.frame.size.width, kSideMenuCellHeight * kRightSideMenuCellNumber) style:UITableViewStylePlain];
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kSQColorDefaultNaviBarColor;

    [self.view addSubview:self.tableView];
}

- (void)dealloc{
    DDLogWarn(@"%@ - dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            SQAboutUsTableViewController *vc = [[SQAboutUsTableViewController alloc] init];
            [UIViewController pushViewControllerByNavigationVCInRevealVCFront:vc];
            break;
        }
        case 1:{
            NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", kAppID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            break;
        }
        case 2:{
            if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
                [self sendEmailAction]; // 调用发送邮件的代码
            }else {
                [self showPopupHUDWihtTitle:@"Error" content:@"Please setting up your e-mail account on iPhone."];
            }
            break;
        }
        case 3:{
            SQDonateViewController *vc = [[SQDonateViewController alloc] init];
            [UIViewController pushViewControllerByNavigationVCInRevealVCFront:vc];
            break;
        }
        default:{
            break;
        }
    }
}


#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSideMenuCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return kRightSideMenuCellNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfRightMenuTableViewCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifierOfRightMenuTableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = kSQDefaultSecondaryBoldFont ;
        cell.textLabel.textColor = kSQColorDefaultPrimaryTextWhiteColor;
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"ABOUT US", @"RATE THIS APP", @"FEEDBACK", @"DONATE"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}

#pragma mark - 邮件反馈功能
- (void)sendEmailAction{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"Want to Help Four"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"kidd_zhangsiqi@163.com"]];
    //邮件正文
    NSString *emailContent = @"You can say anything here.\nPlease be free. :]";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error{
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent ) {
        [self showPopupHUDWihtTitle:@"Success" content:@"Thank you for your feedback!"];
    }else if(result == MFMailComposeResultFailed){
        [self showPopupHUDWihtTitle:@"Error" content:@"Your e-mail sending failed."];
    }
}

#pragma mark - 弹出框相关
- (void)showPopupHUDWihtTitle:(NSString *)title content:(NSString *)content{
    //创建弹出框
    SQAlertViewController *alertVC = [[SQAlertViewController alloc] initWithTitleString:title contentString:content contentSize:CGSizeMake(kPopupViewWidth, kPopupDefaulViewtHeight) rightBarButtonTitle:nil];
    STPopupController *popupController = [STPopupController sq_defalutPopupControllerWithRootVC:alertVC];
    [popupController presentInViewController:self];
}


@end
