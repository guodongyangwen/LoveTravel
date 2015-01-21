//
//  AboutUSViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-6.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()
@property(nonatomic,retain)UIWebView* webView;
@end

@implementation AboutUSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ImageV.image = [UIImage imageNamed:@"appicon.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_ImageV release];
    [_btnPhone release];
    [_btnEmail release];
    [super dealloc];
}
//打电话
- (IBAction)phoneHandle:(id)sender {
    NSString* str = [NSString stringWithFormat:@"tel://%@",_btnPhone.titleLabel.text];
//    [[UIApplication sharedApplication]
//     openURL:[NSURL URLWithString:str]];
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    }
}
//发送邮件
- (IBAction)emailHandle:(id)sender {
    //NSString* str = [NSString stringWithFormat:@"%@",_btnEmail.titleLabel.text];
//    [[UIApplication sharedApplication]
//     openURL:[NSURL URLWithString:str]];
    if(![MFMailComposeViewController canSendMail])
        return;
    MFMailComposeViewController* mailVC = [[MFMailComposeViewController alloc] init];
    //邮件头
    [mailVC setSubject:@"意见反馈"];
    //设置邮件接受者
    [mailVC setToRecipients:@[@"guodongyangw@163.com"]];
    //设置代理
    mailVC.mailComposeDelegate = self;
    
    [self presentViewController:mailVC animated:YES completion:nil];;
    
}


//实现代理方法（邮箱)
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭发邮件页面
    UIAlertView* alert = nil;
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MFMailComposeResultCancelled)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消邮件发送" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1.3];
    }
    else if (result == MFMailComposeResultSent)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮件发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1.3];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮件发送失败" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1.3];
    }
}

@end
