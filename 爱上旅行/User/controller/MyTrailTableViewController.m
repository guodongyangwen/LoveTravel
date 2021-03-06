//
//  MyTrailTableViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-2.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "MyTrailTableViewController.h"

@interface MyTrailTableViewController ()
@property(nonatomic,retain)NSMutableArray* trailArr;//路线数组
@property(nonatomic,copy)NSString* UMUserID;//友盟用户id
@end

@implementation MyTrailTableViewController

-(void)dealloc
{
    self.arr = nil;
    self.trailArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self customizeNB];
    [self getUserID];
    
    [self getDataFromDB];
}


-(void)getUserID
{
    NSDictionary* dic = [UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity* QQAccount = [dic valueForKey:UMShareToQzone];//QQ账号
    UMSocialAccountEntity* SinaAccount = [dic valueForKey:UMShareToSina];//sina账号
    //NSLog(@"QQ:%@,Sina:%@",QQAccount.userName,SinaAccount.userName);
    if(QQAccount.userName)
    {
        self.UMUserID = QQAccount.usid;
    }
    else if (SinaAccount.userName)
    {
        self.UMUserID = SinaAccount.usid;
    }
    else
    {
        self.UMUserID = nil;
    }
    
}


//获取数据
-(void)getDataFromDB
{
    //
    [DataBaseManager openDataBase];
    self.trailArr = (NSMutableArray*)[NSArray array];
    self.trailArr = (NSMutableArray*)[[FileManager sharedFileManager] querryTrailCollectFromDBWithUserID:_UMUserID];
    if ([_trailArr count]==0) {
        NoCollectView *view=[[NoCollectView alloc]initWithFrame:CGRectMake(10, 150, 300, 300)];
        [self.view addSubview:view];
        [view release];
        
    }
    //NSLog(@"arr:%@",_trailArr);
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
    [customLab setText:@"我的路线"];
    self.navigationItem.titleView = customLab;
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame =CGRectMake(0, 0,30 , 20);
    [leftButton addTarget:self action:@selector(leftHandle:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_back_33x44@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}

//返回按钮处理
-(void)leftHandle:(UIButton*)btn
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"数组个数:%ld",[_trailArr count]);
    return [_trailArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSArray* arr = [_trailArr objectAtIndex:indexPath.row];
    NSLog(@"row:%ld",(long)indexPath.row);
    NSData* data = [arr objectAtIndex:0];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    TrailDetail* trail = [[TrailDetail alloc] init];
    [trail setValuesForKeysWithDictionary:dic];
    
    //NSLog(@"id:%@,name:%@",trail.Id,trail.name);
    
    MyTrailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[MyTrailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.trail = trail;
    }
    
    // Configure the cell...
    
    return cell;
}


//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSArray* arrTemp = [_trailArr objectAtIndex:indexPath.row];
    NSData* data = [arrTemp objectAtIndex:0];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    TrailDetail* trail = [[TrailDetail alloc] init];
    [trail setValuesForKeysWithDictionary:dic];
    
    
    //NSLog(@"trailArr:%@",_trailArr);
    self.arr = [NSArray array];
     self.arr = [self.trailArr objectAtIndex:indexPath.row];
    
    //跳转到 详情页面
    TrailDetailViewController* trailDetailVC = [[TrailDetailViewController alloc] init];
    
    trailDetailVC.dataDetail = [_arr objectAtIndex:0];
    trailDetailVC.dataComment = [_arr objectAtIndex:1];
    trailDetailVC.dataRelative = [_arr objectAtIndex:2];
    trailDetailVC.trailId = trail.Id;
    trailDetailVC.titleNB = trail.name;
    trailDetailVC.isRequest = NO;
    
    [self.navigationController pushViewController:trailDetailVC animated:YES];
    [trailDetailVC release];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSArray* arrTemp = [_trailArr objectAtIndex:indexPath.row];
    NSData* data = [arrTemp objectAtIndex:0];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    TrailDetail* trail = [[TrailDetail alloc] init];
    [trail setValuesForKeysWithDictionary:dic];
    
    
    [_trailArr removeObjectAtIndex:indexPath.row];
        
    //删除数据库
//    [[FileManager sharedFileManager] deleteDetailFromDB:trail.Id];
    [[FileManager sharedFileManager] deleteDetailFromDBWithUserID:_UMUserID TrailId:trail.Id];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}





@end
