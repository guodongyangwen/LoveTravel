//
//  UserSetTableViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "UserSetTableViewController.h"

@interface UserSetTableViewController ()
@property(nonatomic,retain)NSMutableArray* userSetTitleArr;
@property(nonatomic,retain)NSArray* iconArr;
@property(nonatomic,retain)UISwitch* swit;//夜间模式
@end

@implementation UserSetTableViewController

-(void)dealloc
{
    self.userSetTitleArr  = nil;
    [super dealloc];
}







- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    if (self) {
        
       
        
        // Custom initialization
        NSString* path = [[NSBundle mainBundle] pathForResource:@"userSet.json" ofType:nil];
        NSData * data = [NSData dataWithContentsOfFile:path];
        //NSLog(@"dat:%@",data);
        NSArray* arr  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.userSetTitleArr = [[NSMutableArray alloc] init];
        self.userSetTitleArr = [NSMutableArray arrayWithArray:arr];
        //NSLog(@"%@",_userSetTitleArr);
        
        //图标数组
        self.iconArr = @[@"0.png",@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"userSet1"]]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    [self customizeNB];
    
}

//自定义NB
-(void)customizeNB
{
    //动画label
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:@"设置"];
    self.navigationItem.titleView = customLab;
    
    //返回按钮
    UIButton* _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backButton.frame = CGRectMake(0, 0, 25, 20);
    
    [_backButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_actionbar_back_33x44@2x.png" ofType:nil]] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_navigationbar_back_33x44@2x.png" ofType:nil]] forState:UIControlStateHighlighted];
    
    [_backButton addTarget:self action:@selector(backHandle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_backButton];
    
}

-(void)backHandle:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"缓存设置";
            break;
        case 1:
            return @"功能设置";
            break;
        case 2:
            return @"其他";
            break;
            
            
        default:
            break;
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            view.backgroundColor = [UIColor clearColor];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 30)];
            label.text = @"缓存设置";
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [label release];
            return view;
        }
            break;
        case 1:
        {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            view.backgroundColor = [UIColor clearColor];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 30)];
            label.text = @"功能设置";
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [label release];
            return view;
        }
            break;
        case 2:
        {  
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            view.backgroundColor = [UIColor clearColor];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 30)];
            label.text = @"其它";
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            [label release];
            return view;
        }
            break;
            
        default:
            break;
    }
    return nil;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

//fwe
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    switch (indexPath.section) {
        case 0://分区1
        {
            cell.imageView.image = [UIImage imageNamed:@"clear.png"];
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1://分区2
        {
            switch (indexPath.row) {
                case 0://夜间模式
                {
                    cell.imageView.image = [UIImage imageNamed:@"dark.png"];
                    cell.textLabel.text = @"夜间模式";
                    self.swit = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
                    NSString* isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"Dark"];
                    //设置开关状态
                    [self.swit setOn:[isOn boolValue]];
                    [_swit addTarget:self action:@selector(darkHandle:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = _swit;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;

                }
                    break;
                case 1://主题
                {
                    cell.imageView.image = [UIImage imageNamed:@"0.png"];
                    cell.textLabel.text = @"主题";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                case 2://推送和通知
                {
                    
                    cell.imageView.image = [UIImage imageNamed:@"3.png"];
                    UISwitch* swit = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
                    [swit setOn:YES];
                    [swit addTarget:self action:@selector(switHandle:) forControlEvents:UIControlEventValueChanged];
                    cell.textLabel.text = @"推送和通知";
                    cell.accessoryView = swit;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
  
        }
        case 2://分区3
        {
            switch (indexPath.row) {
                case 0://关于我们
                {
                    cell.imageView.image = [UIImage imageNamed:@"1.png"];
                    cell.textLabel.text = @"关于我们";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                case 1://检查更新
                {
                    cell.imageView.image = [UIImage imageNamed:@"2.png"];
                    cell.textLabel.text = @"检查更新";
                    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
                    label.text = @"V2.2.0";
                    label.backgroundColor = [UIColor clearColor];
                    cell.accessoryView = label;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                                    break;
                case 2://GWQ工作室
                {
                    cell.imageView.image = [UIImage imageNamed:@"5.png"];
                    cell.textLabel.text = @"GWQ工作室";
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0://清除缓存
        {
            SDImageCache *imageCache=[[SDImageCache alloc]initWithNamespace:@"default"];
            unsigned long sizeL = (unsigned long)[imageCache getSize];
            double sizeF = (double)sizeL/1000000;
            
            NSString* size = [NSString stringWithFormat:@"%.2f", sizeF];
            NSString* message = [NSString stringWithFormat:@"缓存大小:%@M",size];
            
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertV show];
            [alertV release];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0://夜间模式
                {
                    
                }
                    break;
                case 1://设置主题
                {
                    ThemeTVController *themeVC=[[ThemeTVController alloc]initWithStyle:UITableViewStylePlain];
                    themeVC.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
                    themeVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:themeVC animated:YES];
                }
                    break;
                case 2://推送和通知
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0://关于我们
                {
                    AboutUSViewController* about = [[AboutUSViewController alloc] init];
                    about.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:about animated:YES];
                    [about release];
                }
                    break;
                case 1://检查更新
                {
                    UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"检测更新" message:@"即将进入AppStore为您检测最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    [alertV show];
                    [alertV release];
                
                }
                    break;
                case 2://GWQ工作室
                {
                    TLAlertView* alert = [[TLAlertView alloc] initWithTitle:@" 爱上旅行" message:@" 郭东洋\n文闪闪\n齐浩" buttonTitle:@"确定" handler:^(TLAlertView *alertView) {
                        //NSLog(@"清除成功");
                    }];
                    
                    [alert show];
                    [alert release];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SDImageCache *imageCache=[[SDImageCache alloc]initWithNamespace:@"default"];
    unsigned long sizeL = (unsigned long)[imageCache getSize];
    double sizeF = (double)sizeL/1000000;
    
    NSString* size = [NSString stringWithFormat:@"%.2f", sizeF];
    NSString* message = [NSString stringWithFormat:@"缓存大小:%@M",size];
    
    //检查更新
    if (([alertView.title isEqualToString:@"检测更新"])&&buttonIndex==0)
    {
        NSString* str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"956712107"];
        //存放 itunsconnect中得应用程序id
        NSURL *url=[NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if ([alertView.message isEqualToString:message]&&buttonIndex==1)
    {
        //清楚图片缓存
        SDImageCache *imageCache=[[SDImageCache alloc]initWithNamespace:@"default"];
        [imageCache clearMemory];
        [imageCache clearDisk];
        [self.tableView reloadData];
    }
}


//switch处理
-(void)switHandle:(UISwitch*)swit
{
    if(swit.isOn)//开启
    {
        NSLog(@"发送通知");
    }
    else
    {
        NSLog(@"禁用发送通知");
    }
}

//夜间模式
-(void)darkHandle:(UISwitch*)swit
{
    
    if(swit.isOn)//打开
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"Dark"];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:555] setHidden:NO];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"Dark"];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:555] setHidden:YES];
    }
}

@end
