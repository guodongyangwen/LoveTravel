//
//  CollectTVController.m
//  爱上旅行
//
//  Created by 闪 on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "CollectTVController.h"
#import "DetailAct.h"
#import "ActivityList.h"
@interface CollectTVController ()
{
    NSString *userId;
}
@property(nonatomic,retain)NSArray *dataArr;
@property(nonatomic,retain)NSMutableArray *collectArr;
@property(nonatomic,retain)NSMutableArray *activityArr;
@property(nonatomic,retain)DetailAct *detail;
@end

@implementation CollectTVController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    self.dataArr=nil;
    self.collectArr=nil;
    self.activityArr=nil;
    self.detail=nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    [self getUserId];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ActivityCollectTViewCell class] forCellReuseIdentifier:@"collectCell"];
    [self querryData];
    //自定义NB
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


-(void)getUserId
{
    NSDictionary *dic=[UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity *qqEntity=[dic valueForKey:UMShareToQzone ];
    UMSocialAccountEntity *sinaEntity=[dic valueForKey:UMShareToSina];
    
    if (qqEntity.userName) {
        userId=qqEntity.usid;
    }else if(sinaEntity.userName){
        userId=sinaEntity.usid;
    }else{
        userId=nil;
    }
    
}

-(void)querryData
{
    self.activityArr=[[NSMutableArray alloc]init];
    self.collectArr=[[NSMutableArray alloc]init];
    self.dataArr=[[NSArray alloc]init];
    //dataArr数组中每个元素是一个数组 存放完整的详细界面信息  data 和Activity
    self.dataArr=[[FileManager sharedFileManager]querryActivityDataFromDB:userId];
    
    
    //解析数据
    for (NSArray *arr in _dataArr) {
       [_collectArr addObject:[arr firstObject]]; //数据库中的详情data
        
        
        NSDictionary *dic=[arr lastObject];
        
        ActivityList *activity=[[ActivityList alloc]init];
        activity.Id=[dic valueForKey:@"Id"];
        activity.title=[dic valueForKey:@"title"];  //数据库中存的字典activity
        activity.activity_type=[dic valueForKey:@"activity_type"];
        activity.start_time=[dic valueForKey:@"start_time"];
        activity.allDays=[dic valueForKey:@"allDays"];
        activity.end_time=[dic valueForKey:@"end_time"];
        activity.destination=[dic valueForKey:@"destination"];
        activity.cost=[dic valueForKey:@"cost"];
        activity.club=[[Club alloc]init];
        activity.club.title=[dic valueForKey:@"clubTitle"];
        activity.cover=[dic valueForKey:@"cover"];
        activity.club.logo=[dic valueForKey:@"activity.club.logo"];
        
        [_activityArr addObject:activity];
    
        
    }
    
    if ([_activityArr count]==0) {
        NoCollectView *view=[[NoCollectView alloc]initWithFrame:CGRectMake(10, 150, 300, 300)];
        [self.view addSubview:view];
        [view release];
        
    }
    [self.tableView reloadData];
    
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

    return [_activityArr count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcDetailVController *detailVC=[[AcDetailVController alloc]init];
    detailVC.data=[_collectArr objectAtIndex:indexPath.row];
    detailVC.activity=[_activityArr objectAtIndex:indexPath.row];
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.hidesBottomBarWhenPushed=NO;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCollectTViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
    cell.activity=[_activityArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

//删除操纵
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityList *activity=[_activityArr objectAtIndex:indexPath.row];
    //删除数据库
    [[FileManager sharedFileManager]deleteActivityFromDBUserId:userId ActivityId:activity.Id];
    [_collectArr removeObjectAtIndex:indexPath.row];
    [_activityArr removeObjectAtIndex:indexPath.row];
    //删除UI
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
