//
//  TabBarViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TabBarViewController.h"
#import "ActivityViewController.h"

#import "TravelLogViewController.h"
#import "TrailViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //监听主题切换的通知

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
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"tbImage"]]];
    [self.tabBar setNeedsDisplay];

    NSArray *naArr = self.viewControllers;
    for (UINavigationController *navigation in naArr) {
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"naImage"]] forBarMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:[dic valueForKey:@"naImage"]] forBarMetrics:UIBarMetricsDefault];
    //重画
    [self.navigationController.navigationBar setNeedsDisplay];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutViewControllers];
    [self loadImage:[[NSUserDefaults standardUserDefaults]valueForKey:@"theme"]];
   
}
-(void)layoutViewControllers
{
    
    
    //活动  VC
    
    ActivityViewController *activity=[[ActivityViewController alloc]init];
    UINavigationController *activityNa=[[UINavigationController alloc]initWithRootViewController:activity];
    activityNa.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"活动" image:[UIImage imageNamed:@"btn_navigationbar_activity_80x49.png"] tag:0];
    
    //游记
    TravelLogViewController *travelLog = [[TravelLogViewController alloc]init];
    UINavigationController *travelLogNa = [[UINavigationController alloc]initWithRootViewController:travelLog];
    travelLogNa.tabBarItem.title = @"游记";
    travelLogNa.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"btn_navigationbar_log_80x49@2x" ofType:@"png"]];
    
    //路线VC
    
    TrailViewController* trailVC = [[TrailViewController alloc] init];
    UINavigationController* trailNa = [[UINavigationController alloc] initWithRootViewController:trailVC];
    trailNa.tabBarItem.title = @"路线";
    trailNa.tabBarItem.image = [UIImage imageNamed:@"btn_navigationbar_path_80x49.png"];
    
    //用户VC
    UserTableViewController* userVC = [[UserTableViewController alloc] init];
    UINavigationController* userNa = [[UINavigationController alloc] initWithRootViewController:userVC];
    ;
    userVC.tabBarItem.title = @"我的";
    userVC.tabBarItem.image = [UIImage imageNamed:@"btn_navigationbar_me_80x49.png"];
    
    //添加到  tabbar中
    self.viewControllers=@[activityNa,travelLogNa,trailNa,userNa];
    
    
    [activity release];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor , nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //单例
    //设置所有NB的背景图
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"na_bg.jpg"] forBarMetrics:UIBarMetricsDefault];
    //[[UITabBar appearance]setBackgroundColor:[UIColor blackColor]];
    //[[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    //[[UITabBar appearance]setBarStyle:UIBarStyleBlack];
    //[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbarBg.jpg"]];
    //name
    
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
