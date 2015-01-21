//
//  UserTableViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "UserTableViewController.h"
#define identifier_userImageAndName @"imageAndName"
#define identifier_dark @"dark"
#define identifier_collect @"collect"

@interface UserTableViewController ()
@property(nonatomic,retain)NSMutableArray* collectArr;
@property(nonatomic,retain)NSMutableArray* iconArr;
@end

@implementation UserTableViewController

-(void)dealloc
{
    self.collectArr = nil;
    self.iconArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //数组
        self.collectArr = [[NSMutableArray alloc] initWithObjects:@"我的活动",@"我的游记",@"我的路线", nil];
        //图标
        self.iconArr = [[NSMutableArray alloc] initWithObjects:@"btn_navigationbar_activity_selected_80x49@2x",@"btn_navigationbar_log_selected_80x49@2x",@"btn_navigationbar_path_selected_80x49@2x" ,nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_profile_default.jpg"]]];
    [self customizeNB];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
    //NSLog(@"dic:%@",snsAccountDic);
    //获取QQ账号
    UMSocialAccountEntity *QQAccount = [snsAccountDic valueForKey:UMShareToQzone];
    //NSLog(@"name:%@",sinaAccount.userName);
    //获取Sina账号
    UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
    
    if(QQAccount.userName)//QQ用户登录
    {
        
        NSLog(@"name:%@",QQAccount.userName);
        UserImageAndLabelCell* cell = (UserImageAndLabelCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        [cell.userAvatar sd_setImageWithURL:[NSURL URLWithString:QQAccount.iconURL]];
        cell.labelName.text = QQAccount.userName;
        self.navigationItem.title = QQAccount.userName;
        [cell.btnQQ setTitle:@"注销" forState:UIControlStateNormal];
        [cell.btnSina setEnabled:NO];
    }
    else if(sinaAccount.userName)//sina用户登录
    {
        
        UserImageAndLabelCell* cell = (UserImageAndLabelCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        [cell.userAvatar sd_setImageWithURL:[NSURL URLWithString:sinaAccount.iconURL]];
        cell.labelName.text = sinaAccount.userName;
        self.navigationItem.title = sinaAccount.userName;
        [cell.btnSina setTitle:@"注销" forState:UIControlStateNormal];
        [cell.btnQQ setEnabled:NO];
    }
    else//没有登录
    {
        
    }
    
    
    
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
    [customLab setText:@"我"];
    self.navigationItem.titleView = customLab;
    
    
    UIButton* btnSet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSet.frame = CGRectMake(0, 0, 44, 44);
    [btnSet setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_pressed_set_44x44@2x"] forState:UIControlStateNormal];
    [btnSet setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    //[btnSet setShowsTouchWhenHighlighted:YES];
    [btnSet addTarget:self action:@selector(setHandle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSet];
    
    
}

//NB设置按钮 事件处理
-(void)setHandle:(UIButton*)btn
{
    UserSetTableViewController* setVC = [[UserSetTableViewController alloc] init];
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
    [setVC release];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 3;
    }
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 210;
    }
    else
    {
        return 40;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 70;
    }
    
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    //加条线
    UILabel* label_line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    label_line.backgroundColor = [UIColor blackColor];
    [headerView addSubview:label_line];
    [label_line release];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 80, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"我的收藏";
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];
    [label release];
    if(section == 1)
        [headerView setBackgroundColor:[UIColor clearColor]];
    
    return headerView;
    
}

//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0://我的活动
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                //获取QQ账号
                UMSocialAccountEntity *QQAccount = [snsAccountDic valueForKey:UMShareToQzone];
                //获取Sina账号
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                if(QQAccount.userName || sinaAccount.userName)
                {
                    CollectTVController *collectVC=[[CollectTVController alloc]initWithStyle:UITableViewStylePlain];
                    collectVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:collectVC animated:YES];
                }
                else//请登录  提醒
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请您登录" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1];
                    [alert release];
                }
                
            }
                break;
            case 1://我的游记
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                //获取QQ账号
                UMSocialAccountEntity *QQAccount = [snsAccountDic valueForKey:UMShareToQzone];
                //获取Sina账号
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                if(QQAccount.userName || sinaAccount.userName)
                {
                    MyTrailLogTableViewController* myTrailLogVC = [[MyTrailLogTableViewController alloc] init];
                    myTrailLogVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:myTrailLogVC animated:YES];
                    [myTrailLogVC release];
                }
                else
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请您登录" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1];
                    [alert release];
                }
            }
                break;
            case 2://我的路线
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                //获取QQ账号
                UMSocialAccountEntity *QQAccount = [snsAccountDic valueForKey:UMShareToQzone];
                //获取Sina账号
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                if(QQAccount.userName || sinaAccount.userName)
                {
                    MyTrailTableViewController* myTrailVC = [[MyTrailTableViewController alloc] init];
                    myTrailVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:myTrailVC animated:YES];
                    [myTrailVC release];
                }
                else
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请您登录" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
                    [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1];
                    [alert release];
                }
                
            }
                break;
                
            default:
                break;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        UserImageAndLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = (UserImageAndLabelCell*)[[UserImageAndLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_userImageAndName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            //QQ登录按钮  添加点击事件
            [cell.btnQQ addTarget:self action:@selector(QQClickHandle:) forControlEvents:UIControlEventTouchUpInside];
            //Sina登录按钮  添加点击事件
            [cell.btnSina addTarget:self action:@selector(SinaClickHandle:) forControlEvents:UIControlEventTouchUpInside];
            return  cell;
        }
        
    }
    else if(indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier_collect];
            cell.imageView.image = [UIImage imageNamed:[_iconArr objectAtIndex:indexPath.row]];
            [cell.imageView addSubview:[[UIView alloc    ] init]];
            cell.textLabel.text = [_collectArr objectAtIndex: indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    return nil;
}

//QQ按钮点击登录
-(void)QQClickHandle:(UIButton*)btn
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UserImageAndLabelCell* cell = (UserImageAndLabelCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    
    if ([UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToQzone]) {
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQzone  completion:^(UMSocialResponseEntity *response){
            
            //设置登录状态
            NSUserDefaults* userDefault  =  [NSUserDefaults standardUserDefaults];
            [userDefault setValue:@"0" forKey:@"loginState"];
            
            
            NSLog(@"response is %@",response);
            alert.message = @"注销成功。";
            [cell.btnSina setEnabled:YES];
            //把Sina 按钮职位  登录
            [cell.btnQQ setTitle:@"QQ登录" forState:UIControlStateNormal];
            
            [alert show];
            [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
            cell.userAvatar.image = [UIImage imageNamed:@"userIcon.png"];
            cell.labelName.text = @"未登录";
            //            [self changeUserIcon:_headPortrait.image];
            
            
            
        }];
    }else{//登录
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          NSLog(@"登录:%@",response);
                                          NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                          UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToQzone];
                                          NSString * urlString = sinaAccount.iconURL;
                                          NSURL * url = [NSURL URLWithString:urlString];
                                          NSLog(@"%@",urlString);
                                          [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:([NSOperationQueue mainQueue]) completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                              if (data != nil) {
                                                  cell.userAvatar.image = [UIImage imageWithData:data];
                                                  cell.labelName.text = sinaAccount.userName;
                                                  [cell.btnQQ setTitle:@"注销" forState:UIControlStateNormal];
                                                  [cell.btnSina setEnabled:NO];
                                                  //                                                  [self changeUserIcon:_headPortrait.image];
                                                  alert.message = @"成功登录";
                                                  [alert show];
                                                  [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
                                                  
                                              }
                                          }];
                                      });
    }
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{//授权完成
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UserImageAndLabelCell* cell = (UserImageAndLabelCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToQzone];
    NSString * urlString = sinaAccount.iconURL;
    NSURL * url = [NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:([NSOperationQueue mainQueue]) completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSLog(@"usid:%@",sinaAccount.usid);
            
            cell.userAvatar.image = [UIImage imageWithData:data];
            cell.labelName.text = sinaAccount.userName;
            [cell.btnQQ setTitle:@"注销" forState:UIControlStateNormal];
            [cell.btnSina setEnabled:NO];
            //                                                  [self changeUserIcon:_headPortrait.image];
            alert.message = @"登录成功。";
            [alert show];
            [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
        }
    }];
    
    //设置登录状态
    NSUserDefaults* userDefault  =  [NSUserDefaults standardUserDefaults];
    [userDefault setValue:@"1" forKey:@"loginState"];
    //NSLog(@"%@",[userDefault valueForKey:@"loginState"]);
}


//Sina按钮点击登录
-(void)SinaClickHandle:(UIButton*)btn
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

    
    //获取cell
    UserImageAndLabelCell* cell = (UserImageAndLabelCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    if ([UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina])
    {
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            
            [UMSocialAccountManager setIsLoginWithAnonymous:NO];
            
            //设置登录状态
            NSUserDefaults* userDefault  =  [NSUserDefaults standardUserDefaults];
            [userDefault setValue:@"0" forKey:@"loginState"];
            
            alert.message = @"注销成功";
            [alert show];
            [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
            cell.userAvatar.image = [UIImage imageNamed:@"userIcon.png"];
            cell.labelName.text = @"未登录";
            //把QQ 按钮置为   可用状态
            [cell.btnQQ setEnabled:YES];
            //把Sina 按钮职位  登录
            [cell.btnSina setTitle:@"Sina登录" forState:UIControlStateNormal];
            
            //            [self changeUserIcon:_headPortrait.image];
        }];
    }
    else
    {
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          
                                          NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                          UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                                      
                                          
                                          
                                          NSString * urlString = sinaAccount.iconURL;
                                          NSURL * url = [NSURL URLWithString:urlString];
                                          [NSURLConnection sendAsynchronousRequest:([NSURLRequest requestWithURL:url]) queue:([NSOperationQueue mainQueue]) completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                              if (data != nil)
                                              {
                                                  cell.userAvatar.image = [UIImage imageWithData:data];
                                                  cell.labelName.text = sinaAccount.userName;
                                                  
                                                  [cell.btnQQ setEnabled:NO];
                                                  [cell.btnSina setTitle:@"注销" forState:UIControlStateNormal];
                                                  alert.message = @"登录成功";
                                                  [alert show];
                                                  [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
                                              }
                                              
                                              //设置登录状态
                                              NSUserDefaults* userDefault  =  [NSUserDefaults standardUserDefaults];
                                              [userDefault setValue:@"2" forKey:@"loginState"];
                                              NSLog(@"%@",[userDefault valueForKey:@"loginState"]);
                                          }];
                                          
                                          
                                          
                                      });
        
    }
    
    
}

@end
