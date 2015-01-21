//
//  MyDetailViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "MyDetailViewController.h"


@interface MyDetailViewController ()

@end

@implementation MyDetailViewController
-(void)dealloc
{
    self.backButton = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeThemeHandle:) name:kThemeChangeNotification object:nil];
    }
    return self;
}

-(void)changeThemeHandle:(NSNotification*)notification
{
    NSDictionary *dic=notification.userInfo;
    [self loadImage:dic];
    
}

-(void)loadImage:(NSDictionary*)dic
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"naImage"]] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImage:[[NSUserDefaults standardUserDefaults]valueForKey:@"theme"]];
    // Do any additional setup after loading the view.
    //设置   公共navigationItem
    //设置NB背景图片
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"na_bg.jpg" ofType:nil]] forBarMetrics:UIBarMetricsDefault];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backButton.frame = CGRectMake(0, 0, 25, 20);
   
    [_backButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_actionbar_back_33x44@2x.png" ofType:nil]] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_navigationbar_back_33x44@2x.png" ofType:nil]] forState:UIControlStateHighlighted];
    
    [_backButton addTarget:self action:@selector(backHandle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_backButton];
    
         
}


#pragma mark 分享
-(void)shareHandle:(UIButton*)btn
{
    // 弹出横屏页面必须要先使用如下设置屏幕方向的代码，再弹出分享列表页面
    //[UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"54a2a95dfd98c5eb220005af"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToEmail,UMShareToFacebook,UMShareToRenren,UMShareToTwitter,UMShareToDouban,nil]
                                       delegate:self];
    
}


//实现  分享 的 回调函数，可以直接分享，不用编辑分享内容。
//-(BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}

//回调方法
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    NSLog(@"分享成功");
//}

#pragma mark NB按钮事件处理
-(void)backHandle:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
