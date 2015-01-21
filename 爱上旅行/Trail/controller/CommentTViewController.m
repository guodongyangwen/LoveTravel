//
//  CommentTViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CommentTViewController.h"

@interface CommentTViewController ()
@property(nonatomic,retain)NSMutableArray* commentArr;//评论数组
@property(nonatomic,retain)RequestHandle* scoreRequestHandle;//评论数据请求
@property(nonatomic,retain)UITableView* tableView;

@end

@implementation CommentTViewController

-(void)dealloc
{
    self.commentArr = nil;
    self.trailId = nil;
    self.commentArr = nil;
    self.scoreRequestHandle = nil;
    self.tableView = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scoreRequestHandle cancelConnection];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNB];
    [self requestData];//请求数据
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutTableView];
}


-(void)layoutTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 504)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    [_tableView release];
    
}



#pragma mark 自定义NB
-(void)customizeNB
{
    //动画label  标题
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:[NSString stringWithFormat:@"评价%@",_commentTrail]];
    self.navigationItem.titleView = customLab;
    
    //返回按钮
    //
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame =CGRectMake(0, 0,33 , 44);
    [leftButton addTarget:self action:@selector(leftHandle:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_navigationbar_back_33x44@2x"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}


//数据请求
-(void)requestData
{
    //**************************************************************路线评论数据请求
    //创建数组
    self.commentArr = [[NSMutableArray alloc] initWithCapacity:2];
    //拼接URL
    NSString* scoreURLString = [kTrailDetail_lostId stringByAppendingString:_trailId];
    scoreURLString = [scoreURLString stringByAppendingString:@"/score"];
    //一次请求20条
    scoreURLString = [scoreURLString stringByAppendingString:@"?app_version=1.0.2&device_type=1&page=1&page_size=20&access_token=9c659546-c684-43c0-8f4a-7feeb8ce400f"];
    
    self.scoreRequestHandle = [[RequestHandle alloc] initWithURLString:scoreURLString paramString:nil method:@"GET" delegate:self];
}


//返回按钮处理
-(void)leftHandle:(UIButton*)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return [_commentArr count];
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //自适应高度
    CommentModal* com = [_commentArr objectAtIndex:indexPath.row];
    CGFloat height = [NSString getHeightWithText:com.comment ViewWidth:300 fontSize:15];
    return 85 + height + 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customizeCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(!cell)
    {
        cell = [[customizeCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置cell
    cell.comment = [_commentArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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


//数据请求成功
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    NSError* err = nil;
    NSDictionary* dicWide = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
    //NSLog(@"dic_comments:%@",dicWide);
    if(err)
    {
        NSLog(@"数据请求错误：%@",err);
    }
    else if(!err && !data)
    {
        NSLog(@"数据请求没有错误，但是没有请求到数据");
    }
    else//请求成功
    {
        
        //解析数据
        NSArray* comments = [dicWide objectForKey:@"comments"];
        for (NSDictionary* comDic in comments) {
            CommentModal* c = [[CommentModal alloc] init];
            [c setValuesForKeysWithDictionary:comDic];
            [_commentArr addObject:c];
        }
        
    }
    
    //重新加载数据
    [self.tableView reloadData];
    
    
}
//数据请求失败
-(void)requestHandle:(RequestHandle *)requestHandle requestFailedWithError:(NSError *)error
{
    //取消请求
    [self.scoreRequestHandle cancelConnection];
}


@end
