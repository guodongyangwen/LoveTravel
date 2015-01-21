//
//  TrailViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TrailViewController.h"
#import "MJRefresh.h"
#import "RequestHandle.h"



@interface TrailViewController ()
@property(nonatomic,retain)NSMutableArray* trailArray;//路线数组
@property(nonatomic,assign)int is_refresh;//是刷新（1）还是加载（0）
@property(nonatomic,copy) NSString* cur_page;//当前页(int->string)
@property(nonatomic,copy)NSString* total;//路线总数
@property(nonatomic,copy)NSString* total_pages;//总页数(int->string)
@property(nonatomic,retain)BufferingView* buffView;//加载控件


//数据请求
@property(nonatomic,retain)RequestHandle* allTrailsRequest;//所有路线请求
@end

@implementation TrailViewController

-(void)dealloc
{
    self.segTitle = nil;
    self.scrollView = nil;
    self.trailType = nil;
    self.crowdArr = nil;
    self.trailArray = nil;
    self.cur_page = nil;
    self.total = nil;
    self.total_pages = nil;
    self.buffView = nil;
    self.allTrailsRequest = nil;
    [super dealloc];
}

//数据懒加载
-(NSMutableArray*)trailArray
{
    if(!_trailArray)
    {
        self.trailArray = [[NSMutableArray alloc] init];
    }
    return _trailArray;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //地区数组
        self.areaArr = @[@"西藏",@"新疆",@"浙江",@"云南",@"四川",@"安徽",@"广东",@"内蒙古",@"北京",@"陕西",@"湖南",@"河北",@"福建",@"贵州",@"广西",@"江西"];
        //人群数组
        self.crowdArr = @[@"休闲派",@"技术流",@"重装客",@"探险家",@"享乐派",@"户二代",@"人文客",@"摄影控",@"独行侠"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义NB
    [self customizeNB];
    [self addActivityIndicator];
    [self requestData];
    
    [self layoutScrollView];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.allTrailsRequest cancelConnection];
    [super viewWillDisappear:animated];
}

//布局scrollView
-(void)layoutScrollView
{
    //******************************************************************scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    //设置属性
    _scrollView.contentSize = CGSizeMake(640, 504);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    //设置代理
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    //******************************************************************TableViewType专题
    TrailTypeTableViewController* trailTypeTVC = [[TrailTypeTableViewController alloc] init];
    trailTypeTVC.view.frame = CGRectMake(320, 0, 320, 455);
    [_scrollView addSubview:trailTypeTVC.view];
    
    
#pragma mark 获取scrollView的  NC
    trailTypeTVC.superNavigationController = self.navigationController;
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
    self.segTitle = [[UISegmentedControl alloc] initWithItems:@[@"路线库",@"专题"]];
    _segTitle.frame = CGRectMake(60, 5, 150, 30);
    //默认选中项
    _segTitle.selectedSegmentIndex = 0;
    _segTitle.tintColor = [UIColor whiteColor];
    
    //添加点击事件
    [_segTitle addTarget:self action:@selector(segHandle:) forControlEvents:UIControlEventValueChanged];
    //设置  NB 的titleView
    self.navigationItem.titleView = _segTitle;
    [_segTitle release];
    
    
    //搜索按钮
    UIButton* btnSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSearch setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_search_44x44@2x"] forState:UIControlStateNormal];
    btnSearch.frame = CGRectMake(0, 0, 44, 44);
    //添加点击事件
    [btnSearch addTarget:self action:@selector(searchHandle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSearch];

}



//segment点击时间处理
-(void)segHandle:(UISegmentedControl*)seg
{
    if(seg.selectedSegmentIndex == 0)//路线库
    {
        [UIView beginAnimations:@"切换路线" context:seg];
        [UIView setAnimationDuration:0.3];
        _scrollView.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    else if(seg.selectedSegmentIndex == 1)//路线专题
    {
        [UIView beginAnimations:@"切换路线" context:seg];
        [UIView setAnimationDuration:0.3];
        _scrollView.contentOffset = CGPointMake(320, 0);
        [UIView commitAnimations];
    }
}
//布局视图
-(void)layoutTableViews
{
    
    
    //布局两个tableView
    //******************************************************************tableView1
    //路线库
    self.trailLib = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 455)];
    _trailLib.tag = 101;
    
    //设置数据源和代理
    _trailLib.dataSource = self;
    _trailLib.delegate = self;
    
    //添加上拉刷新，下拉加载更多
    [_trailLib addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [_trailLib addFooterWithTarget:self action:@selector(footerRereshing)];
    _trailLib.headerPullToRefreshText = @"下拉刷新";
    _trailLib.headerReleaseToRefreshText = @"马上刷新";
    _trailLib.headerRefreshingText = @"爱上旅行正在帮您刷新";
    
    _trailLib.footerPullToRefreshText = @"上拉加载更多";
    _trailLib.footerReleaseToRefreshText = @"马上加载更多";
    _trailLib.footerRefreshingText = @"爱上旅行正在加载";

    _trailLib.showsVerticalScrollIndicator = NO;
    
    //_trailLib.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:_trailLib];
    [_trailLib release];
    
}


#pragma mark  数据加载
//下拉刷新
-(void)headerRefreshing
{
    _is_refresh = 0;//下拉刷新
     [[RequestHandle alloc] initWithURLString:kAllTrail paramString:nil method:@"GET" delegate:self];
    
}

-(void)footerRereshing
{
    _is_refresh = 1;//加载更多
    //下一页
    self.cur_page = [NSString stringWithFormat:@"%d",(_cur_page.intValue + 1)];
    NSString* urlString = [kAllTrail_lostPage stringByAppendingString:[NSString stringWithFormat:@"&page=%@",_cur_page                                                           ]];
    [[RequestHandle alloc] initWithURLString:urlString paramString:nil method:@"GET" delegate:self];

}

#pragma mark scrollView  delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x > 160)
    {
        _segTitle.selectedSegmentIndex = 1;
    }
    else if(scrollView.contentOffset.x < 160)
    {
        _segTitle.selectedSegmentIndex = 0;
    }
}


#pragma mark tableView  delegate
/**
 *  实现tableView的代理方法
 */

//区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.trailArray.count;
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
//标题高度


//设置cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"trailCell"];
    if(!cell)
    {
        cell = [[TrailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trailCell"];
    }
    
    //获取数据
    Trail* trail = [_trailArray objectAtIndex:indexPath.row];
    
    //路线名称
    cell.label_name.text = trail.name;
    //目的地
    cell.label_destination.text = trail.destination;
    //封面
    PlaceholdAnimateView* placeAnimation = [[PlaceholdAnimateView alloc]initWithFrame:CGRectMake(140, 70, 40, 40)];
    [cell.imageView_cover addSubview:placeAnimation];
    [placeAnimation start];
    [cell.imageView_cover sd_setImageWithURL:[NSURL URLWithString:trail.cover] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.imageView_cover.image = image;
        [placeAnimation cancel];
    }];
    
    //星级
    cell.score = trail.trail_score;
    //是否最新
    //cell.isNew = trail.is_new;
    
    
    //设置cell选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    Trail* trail = [_trailArray objectAtIndex:indexPath.row];
    TrailDetailViewController* trailDetailVC = [[TrailDetailViewController alloc] init];
    
    trailDetailVC.titleNB = trail.name;
    trailDetailVC.trailId = trail.Id;
    
    trailDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:trailDetailVC animated:YES];
    //trailDetailVC.hidesBottomBarWhenPushed=NO;
    [trailDetailVC release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//搜索按钮事件处理
-(void)searchHandle:(UIButton*)btn
{
    TrailSearchViewController* searchVC = [[TrailSearchViewController alloc] init];
    //实现block块
    searchVC.passValue = ^(NSString* text){
        //获取传过来的参数
        _is_refresh = -1;
        NSString* hot_area = @"";
        NSString* crowd = @"";
        if([_areaArr containsObject:text])
        {
            hot_area = text;
        }
    
        if([_crowdArr containsObject:text])
        {
            crowd = [NSString stringWithFormat:@"%lu",([_crowdArr indexOfObject:text] + 2)];
        }
        
        NSString* search = text;//搜索内容
        
        
        /*http://tubu.ibuzhai.com/rest/v1/trails?&page_size=20&area_id=&page=1&search=%E6%8A%80%E6%9C%AF%E6%B5%81&device_type=2&app_version=2.2.0&hot_area=&api_version=1&crowd=3&access_token=&trait=0*/
        NSString* urlString = [kTrailSearch stringByAppendingFormat:@"&search=%@&crowd=%@&hot_area=%@",search,crowd,hot_area];
        [[RequestHandle alloc]initWithURLString:urlString  paramString:nil method:@"GET" delegate:self];
    };
    
    UINavigationController* na = [[UINavigationController alloc] initWithRootViewController:searchVC];
    na.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:na animated:YES completion:nil];
    [searchVC release];
}

#pragma mark  请求数据
-(void)requestData
{
    //创建 路线数组，存放  封装后的对象
    [self trailArray];
    _is_refresh = -1;//第一次刷新
    self.allTrailsRequest = [[RequestHandle alloc] initWithURLString:kAllTrail paramString:nil method:@"GET" delegate:self];

}

#pragma mark  数据请求代理方法
//请求成功
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
                    self.trailArray = nil;
                    for (NSDictionary* dic in arr) {
                        Trail* trail = [[Trail alloc] init];
                        [trail setValuesForKeysWithDictionary:dic];//kvc
                        [self.trailArray addObject:trail];//添加
                    }
                    [self layoutTableViews];
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
        [_trailLib headerEndRefreshing];
        [_trailLib footerEndRefreshing];
        [_trailLib reloadData];
    //[_trailLib reloadInputViews];
        [self.buffView removeFromSuperview];
        

    
}
//请求失败
-(void)requestHandle:(RequestHandle *)requestHandle requestFailedWithError:(NSError *)error
{
    if(requestHandle == self.allTrailsRequest)
    {
        [self.allTrailsRequest cancelConnection];
    }
}

@end
