//
//  MyTrailLogTableViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-2.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "MyTrailLogTableViewController.h"

@interface MyTrailLogTableViewController ()
@property(nonatomic,retain)NSMutableArray* trailLogArr;
@property(nonatomic,copy)NSString* UMUserID;//友盟ID
@end

@implementation MyTrailLogTableViewController
-(void)dealloc
{
    self.trailLogArr = nil;
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
    
    [self getUserID];//获取用户ID
    [self customizeNB];
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
    self.trailLogArr = [NSMutableArray array];
//    self.trailLogArr = (NSMutableArray*)[[FileManager sharedFileManager] querryTrailLogDataFromDB];
    self.trailLogArr = (NSMutableArray*)[[FileManager sharedFileManager] querryTrailLogDataFromDBWithuserID:_UMUserID];
    if ([_trailLogArr count]==0) {
        NoCollectView *view=[[NoCollectView alloc]initWithFrame:CGRectMake(10, 150, 300, 300)];
        [self.view addSubview:view];
        [view release];
        
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
    [customLab setText:@"我的游记"];
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
    //NSLog(@"count:%ld",[_trailLogArr count]);
    return [_trailLogArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    
    NSArray* arr = [_trailLogArr objectAtIndex:indexPath.row];
    NSDictionary* dic = [arr objectAtIndex:1];
    
    TravelLog* trailDetail = [[TravelLog alloc] init];
    [trailDetail setValuesForKeysWithDictionary:dic];
    
    MyTrailLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[MyTrailLogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.trailDetail = trailDetail;
    }
    
    // Configure the cell...
    
    return cell;
}

//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    
    NSArray* arr = [_trailLogArr objectAtIndex:indexPath.row];
    NSDictionary* dic = [arr objectAtIndex:1];
    TravelLog* trailDetail = [[TravelLog alloc] init];
    [trailDetail setValuesForKeysWithDictionary:dic];
    
    NSData* data1 = [arr objectAtIndex:0];
    
    
    //跳转到详情页面
    DetaiTLViewController* detailVC = [[DetaiTLViewController alloc] init];
    detailVC.travelLog = trailDetail;
    detailVC.dataLogs = data1;
    detailVC.isAnalysis = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
    
}


//删除

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arr = [_trailLogArr objectAtIndex:indexPath.row];
    NSDictionary* dic = [arr objectAtIndex:1];
    
    
    [_trailLogArr removeObjectAtIndex:indexPath.row];
//    [[FileManager sharedFileManager] deleteTrailLogFromDB:[dic objectForKey:@"TravelLogId"]];
    //删除数据库
    [[FileManager sharedFileManager] deleteTrailLogFromDBWithUserID:_UMUserID ID:[dic objectForKey:@"TravelLogId"]];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end
