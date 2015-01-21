//
//  TravelLogViewController.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TravelLogViewController.h"
#import "DetaiTLViewController.h"
#import "TLTableViewCell.h"
#import "TravelLog.h"

#import "RequestHandle.h"
#import "UIImageView+WebCache.h" //下载图片
#import "BufferingView.h" //缓冲动画
#import "MJRefresh.h"
@interface TravelLogViewController ()<RequestHandleDelegate>

@property(nonatomic,copy) NSString *page, *page_size,*downPage;
@property(nonatomic,retain)TravelLog *travelLog;
@property(nonatomic,retain)BufferingView *loadingView; //缓冲视图

@property(nonatomic,assign)int is_refresh;//是刷新（0）还是加载（-1）
@property(nonatomic,retain)RequestHandle *request;


@property(nonatomic,retain)NSMutableArray* travelLogArr;//游记数组


@end

@implementation TravelLogViewController


-(void)dealloc
{
    self.page = nil;
    self.page_size = nil;
    self.downPage = nil;
    self.request = nil;
    self.travelLogArr = nil;
    self.travelLog =nil;
    self.loadingView = nil;
    self.titleNB = nil;
    [super dealloc];
}
//数据懒加载
-(NSMutableArray*)travelLogArr
{
    if(!_travelLogArr)
    {
        self.travelLogArr = [[NSMutableArray alloc] init];
    }
    return _travelLogArr;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.page=@"1";
        self.page_size=@"20";
        self.downPage = [NSString stringWithFormat:@"%d",1];
        
        self.is_refresh = -1; //记录刷新或加载状态 -1表示首次打开
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.request cancelConnection];
}
- (void)viewDidLoad
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];
    [self customizeNavagationBar];

    //返回
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    
    //注册cell
    [self.tableView registerClass:[TLTableViewCell class] forCellReuseIdentifier:@"travleLog"];
    
    //请求数据
    [self requestData];
    //刷新
    [self setUpRefresh];
    
    //添加兔子
    self.loadingView = [[BufferingView alloc]init];
    [self.loadingView start];
    [self.view addSubview:_loadingView];
    
    
}
//自定义title的动画
-(void)customizeNavagationBar
{
    //title的动画
    CUSFlashLabel *customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 10, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:self.titleNB];
    customLab.text = @"游记";
    self.navigationItem.titleView = customLab;
    
}

//刷新
-(void)setUpRefresh
{
    //添加上拉刷新，下拉加载更多
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"travelLog"];
    [self.tableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"马上刷新";
    self.tableView.headerRefreshingText = @"爱上旅行正在帮您刷新";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"马上加载更多";
    self.tableView.footerRefreshingText = @"爱上旅行正在加载";


}
-(void)headerRefreshing
{
    self.is_refresh = 0;
    [self requestData];
}
-(void)footRefreshing
{
    self.is_refresh = 1;
    [self requestData];
}
#pragma mark ------数据请求-----
//请求数据
-(void)requestData
{
    //如果上拉加载，那么请求的是下一页的数据
    if (_is_refresh==1) {
        self.downPage=[NSString stringWithFormat:@"%d",[self.downPage intValue]+1];
        self.page=_downPage;
    }else{
        self.page=@"1";
    }
    
    NSString *url=[kTravelLog stringByAppendingString:[NSString stringWithFormat:@"&page=%@&page_size=%@",_page,_page_size]];
    
    //请求数据
    self.request = [[RequestHandle alloc]initWithURLString:url paramString:nil method:@"GET" delegate:self];
    
    
}

-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dataDic objectForKey:@"logs"];

    for (NSDictionary *dic in array) {
        //封装数据
        _travelLog = [[TravelLog alloc]init];
        [_travelLog setValuesForKeysWithDictionary:dic];
        
        [self travelLogArr];
       //在此判断是首次加载   下拉刷新   上拉加载
        if (_is_refresh == -1) {
            
            [self.travelLogArr addObject:_travelLog];
            
        }else if (_is_refresh == 0)
        {
            //下拉刷新
            BOOL same = NO;
            for (int i = 0 ; i <[_travelLogArr count];  i ++) {
                TravelLog *travel = _travelLogArr[i];
                if ([_travelLog.name isEqualToString:travel.name]) {
                    same=YES;
                    break;
                }
             }
            if (same==NO) {
                [_travelLogArr insertObject:_travelLog atIndex:0];
            }
        }else if (_is_refresh==1){
            
           [_travelLogArr addObject:_travelLog];
         }
        
        [_travelLog release];
    }
    
    //关掉加载视图
    [self.tableView reloadData];
    _is_refresh=-1; //数据请求结束  回至开始状态，无刷新和加载
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.loadingView cancel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.travelLogArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travleLog" forIndexPath:indexPath];
    
    TravelLog *travelLog = [self.travelLogArr objectAtIndex:indexPath.row];
    cell.travelLog = travelLog;
    
    // Configure the cell...
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;


}

#pragma ---------点击cell--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetaiTLViewController *DTLView = [[DetaiTLViewController alloc]init];
    //传值
    TravelLog *travelLog =[self.travelLogArr objectAtIndex:indexPath.row];
    travelLog.nickname = travelLog.author.nickname;
    travelLog.avatar = travelLog.author.avatar;
    DTLView.travelLog = travelLog;
    //NSLog(@"log:%@",travelLog.author.nickname);
    DTLView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:DTLView animated:YES];
   
    
    
}


@end
