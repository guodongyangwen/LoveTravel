//
//  TrailListOfTypeTableViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TrailListOfTypeTableViewController.h"
#define identifier @"cell"

@interface TrailListOfTypeTableViewController ()
@property(nonatomic,retain)NSMutableArray* trailArray;//路线数组
@property(nonatomic,assign)int is_refresh;//是刷新（1）还是加载（0）
@property(nonatomic,copy) NSString* cur_page;//当前页(int->string)
@property(nonatomic,retain)BufferingView* buffView;//加载控件
//数据请求
@property(nonatomic,retain)RequestHandle* allTrailsRequest;//所有路线请求
@end

@implementation TrailListOfTypeTableViewController

-(void)dealloc
{
    self.backButton = nil;
    self.trailTypeId = nil;
    self.titleNB = nil;
    self.trailArray = nil;
    self.cur_page = nil;
    self.buffView = nil;
    self.allTrailsRequest = nil;
    
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


-(void)viewWillDisappear:(BOOL)animated
{
    [self.allTrailsRequest cancelConnection];
    [super viewWillDisappear:animated];
}

-(NSMutableArray *)trailArray
{
    if(!_trailArray)
    {
        _trailArray = [[NSMutableArray alloc] init];
    }
    return _trailArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //自定义NB
    [self customizeNB];
    [self addActivityIndicator];
    [self requestData];
    
    //注册cell
    [self.tableView registerClass:[TrailTableViewCell class] forCellReuseIdentifier:identifier];;
}

//添加加载控件
-(void)addActivityIndicator
{
    
    self.buffView  = [[BufferingView alloc] init];
    [self.view addSubview:_buffView];
    [_buffView start];
    
    
}

//自定义 NB的标题
-(void)customizeNB
{
    //动画label
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:_titleNB];
    self.navigationItem.titleView = customLab;
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backButton.frame = CGRectMake(0, 0, 30, 30);
    
    [_backButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_actionbar_back_33x44@2x.png" ofType:nil]] forState:UIControlStateNormal];
    
    [_backButton addTarget:self action:@selector(backHandle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_backButton];
}

-(void)backHandle:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


//请求数据
-(void)requestData
{
    //创建 路线数组，存放  封装后的对象
    [self trailArray];
    _is_refresh = -1;//第一次刷新
    NSString* urlString = [kTypeTrailList stringByAppendingFormat:@"/%@?app_version=%@&page_size=20&page=1&device_type=1",_trailTypeId,App_version];
   
    self.allTrailsRequest = [[RequestHandle alloc] initWithURLString:urlString paramString:nil method:@"GET" delegate:self];
}

-(void)layoutTableViews
{
    //添加上拉刷新，下拉加载更多
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"马上刷新";
    self.tableView.headerRefreshingText = @"爱上旅行正在帮您刷新";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"马上加载更多";
    self.tableView.footerRefreshingText = @"爱上旅行正在加载";
    
    self.tableView.showsVerticalScrollIndicator = NO;
}


#pragma mark  数据加载
//下拉刷新
-(void)headerRefreshing
{
    _is_refresh = 0;//下拉刷新
    NSString* urlString = [kTypeTrailList stringByAppendingFormat:@"/%@?app_version=%@&page_size=20&page=1&device_type=1",_trailTypeId,App_version];
    [[RequestHandle alloc] initWithURLString:urlString paramString:nil method:@"GET" delegate:self];
    
}

-(void)footerRereshing
{
    _is_refresh = 1;//加载更多
    //下一页
    self.cur_page = [NSString stringWithFormat:@"%d",(_cur_page.intValue + 1)];
    NSString* urlString = [kTypeTrailList stringByAppendingFormat:@"/%@?app_version=%@&page_size=20&device_type=1&page=%@",_trailTypeId,App_version,_cur_page];
    [[RequestHandle alloc] initWithURLString:urlString paramString:nil method:@"GET" delegate:self];
    
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
    
    return [_trailArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    //获取数据
    Trail* trail = [_trailArray objectAtIndex:indexPath.row];
    
    //路线名称
    cell.label_name.text = trail.name;
    //目的地
    cell.label_destination.text = trail.destination;
    //封面
    PlaceholdAnimateView* place = [[PlaceholdAnimateView alloc] initWithFrame:CGRectMake(140, 70, 40, 40)];
    [cell.imageView_cover addSubview:place];
    [place start];
    
    [cell.imageView_cover sd_setImageWithURL:[NSURL URLWithString:trail.cover] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [place cancel];
    }];
    //星级
    cell.score = trail.trail_score;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    Trail* trail = [_trailArray objectAtIndex:indexPath.row];
    TrailDetailViewController* trailDetailVC = [[TrailDetailViewController alloc] init];
    
    trailDetailVC.titleNB = trail.name;
    trailDetailVC.trailId = trail.Id;
    
    trailDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:trailDetailVC animated:YES];
    trailDetailVC.hidesBottomBarWhenPushed=NO;
    [trailDetailVC release];
}




#pragma mark 数据请求
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    NSError* err = nil;
    NSDictionary* dicWide = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
    if(err)
    {
        NSLog(@"数据请求错误：%@",err);
    }
    else if (!err && !data)
    {
        NSLog(@"数据没有错误，但是也没有请求到");
    }
    else//请求成功
    {
        self.cur_page = [NSString stringWithFormat:@"%@",[dicWide objectForKey:@"cur_page"]];
        //解析路线数组
        NSArray* arr = [dicWide objectForKey:@"trails"];
        [self trailArray];
        if(_is_refresh == 0)//下拉刷新
        {
            for (int i=(int)[arr count]-1;i>=0;i--)
            {
                NSDictionary* dic = [arr objectAtIndex:i];//倒序获取，插入最新的
                Trail* trail = [[Trail alloc] init];
                [trail setValuesForKeysWithDictionary:dic];//kvc
                
                if(_is_refresh == 1)//加载
                {
                    [self.trailArray addObject:trail];
                }
                else if(_is_refresh == 0)//下拉刷新
                {
                    int flag = 0;
                    for (int i=0;i<_trailArray.count;i++) {
                        Trail* t = [_trailArray objectAtIndex:i];
                        if([t.name isEqualToString:trail.name])
                        {
                            flag = 1;
                            break;
                        }
                        else
                        {
                            flag = 0;
                        }
                    }
                    if(flag == 0)
                    {
                        [self.trailArray insertObject:trail atIndex:0];
                    }
                    
                }
                else if(_is_refresh == -1)//第一次刷新
                {
                    [self.trailArray addObject:trail];//添加
                }
                
                
            }
        }
        else//第一次，或者上拉加载
        {
            if(_is_refresh == -1)
            {
                for (NSDictionary* dic in arr) {
                    Trail* trail = [[Trail alloc] init];
                    [trail setValuesForKeysWithDictionary:dic];//kvc
                    //NSLog(@"%@",trail.name);
                    [self.trailArray addObject:trail];//添加
                }
                [self layoutTableViews];
                NSLog(@"count:%ld",[_trailArray count]);
            }
            else
            {
                for (NSDictionary* dic in arr) {
                    Trail* trail = [[Trail alloc] init];
                    [trail setValuesForKeysWithDictionary:dic];//kvc
                    [self.trailArray addObject:trail];//添加
                }
            }
            
        }
        
    }
    
    // 刷新表格
    _is_refresh = -1;
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.tableView reloadData];
    [self.buffView removeFromSuperview];
}

-(void)requestHandle:(RequestHandle *)requestHandle requestFailedWithError:(NSError *)error
{
    [self.allTrailsRequest cancelConnection];
}
@end
