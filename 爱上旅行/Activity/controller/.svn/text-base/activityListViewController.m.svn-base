//
//  activityListViewController.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "activityListViewController.h"
#import "ActivityTableViewCell.h"

@interface activityListViewController ()
@property(nonatomic,copy)NSString *app_version, *activity_category_id,*activity_type_id, *city, *cur_page, *device_type, *is_recent, *page_size, *sort, *trail_id,*destination;


@property(nonatomic,retain)UITableView *listTableView;
@property(nonatomic,retain)UITableView *cityTableV;
@property(nonatomic,retain)UIImageView *accessoryView;
@property(nonatomic,retain)NSMutableArray *cityArr;
@property(nonatomic,retain)NSMutableArray *cityNumArr;
@property(nonatomic,retain)NSMutableArray *activityArr;
@property(nonatomic,retain)UIView *blackView;


@property(nonatomic,retain)BufferingView *buffView;
@property(nonatomic,retain)RequestHandle *request;

@property(nonatomic)int is_header;

@property(nonatomic,copy)NSString *urlStr;
@end

@implementation activityListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.app_version=@"1.0.2";
        self.activity_category_id=@"3";
        self.activity_type_id=@"0";
        self.city=@"0";
        self.cur_page=@"1";
        self.device_type=@"1";
        self.is_recent=@"0";
        self.page_size=@"20";
        self.sort=@"0";
        self.trail_id=@"0";
        

        self.is_header=0;  //记录刷新或加载状态 -1表示首次打开
        
        self.cityArr=[[NSMutableArray alloc]init];
        NSArray *array=[[NSArray alloc]init];
        array = @[@"全国",@"北京市",@"上海市",@"杭州市",@"广州市",@"深圳市",@"成都市"];
        for (NSString *obj in array) {
            [_cityArr addObject:obj];
        }
        self.cityNumArr=[[NSMutableArray alloc]init];
        array=@[@"0",@"2",@"3",@"213",@"326",@"328",@"382"];
        for (NSString *obj in array) {
            [_cityNumArr addObject:obj];
        }
    
    
    }
    return self;
}

-(void)dealloc
{
    self.urlId = nil;
    self.title = nil;
    self.app_version=nil;
    self.activity_category_id=nil;
    self.activity_type_id=nil;
    self.city=nil;
    self.cur_page=nil;
    self.device_type=nil;
    self.is_recent=nil;
    self.page_size=nil;
    self.sort=nil;
    self.trail_id=nil;
    self.cityArr=nil;
    self.cityTableV=nil;
    self.accessoryView=nil;
    self.activityArr=nil;
    self.blackView=nil;
    self.buffView=nil;
    [super dealloc];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self requestData];

    [self createTableView];
    [self setNavigaitonBar];
    
    [self setUpRefresh];
    [self layoutCityTableView];
    
}
#pragma mark --创建城市搜索视图--
-(void)layoutCityTableView
{
    self.blackView=[[UIView alloc]initWithFrame:self.view.bounds];
    
    _blackView.backgroundColor=[UIColor blackColor];
    _blackView.alpha=0.6;

    
    self.
    self.cityTableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 220, 280) style:UITableViewStylePlain];
    _cityTableV.delegate=self;
    _cityTableV.dataSource=self;
    [_cityTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    [self.view addSubview:_cityTableV];
    _cityTableV.hidden=YES;
    _cityTableV.showsVerticalScrollIndicator=NO;
    self.accessoryView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    _accessoryView.image=[UIImage imageNamed:@"icon_selected_24x24@2x.png"];
   
}

#pragma mark --刷新控件设置--
-(void)setUpRefresh
{
    //添加上拉刷新，下拉加载更多
    [self.listTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"activity"];
    [self.listTableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    self.listTableView.headerPullToRefreshText = @"下拉刷新";
    self.listTableView.headerReleaseToRefreshText = @"马上刷新";
    self.listTableView.headerRefreshingText = @"爱上旅行正在帮您刷新";
    
    self.listTableView.footerPullToRefreshText = @"上拉加载更多";
    self.listTableView.footerReleaseToRefreshText = @"马上加载更多";
    self.listTableView.footerRefreshingText = @"爱上旅行正在加载";

}
-(void)headerRefreshing
{
    self.is_header=1;
    [self requestData];
    
}
-(void)footRefreshing
{
    self.is_header=2;
    [self requestData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.request cancelConnection];
}
#pragma mark --数据请求--
-(void)requestData
{
    
    //当前要请求的页
    NSString *page=[NSString stringWithFormat:@"%d",1];
    //如果上拉加载，那么请求的是下一页的数据
    if (_is_header==2) {
        NSInteger pageS=[self.cur_page integerValue];
        self.cur_page=[NSString stringWithFormat:@"%ld",pageS+1];
        page=self.cur_page;
    }
    //拼接参数
    NSString *string=[NSString stringWithFormat:@"app_version=%@&activity_category_id=%@&activity_type_id=%@&city=%@&cur_page=%@&device_type=%@&is_recent=%@&page_size=%@&sort=%@&trail_id=%@",self.app_version,self.urlId,self.activity_type_id,self.city,page,self.device_type,self.is_recent,self.page_size,self.sort,self.trail_id];
    NSString *url=[kActivityList stringByAppendingString:string];
    self.urlStr=url;
    
   self.request = [[RequestHandle alloc]initWithURLString:url paramString:nil method:@"GET" delegate:self];
}

-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    NSDictionary *dicData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr=[dicData valueForKey:@"activities"];
   
    if ([arr count]==0) {
       UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"爱上旅途" message:@"没有您需要的信息" delegate:self cancelButtonTitle:@"抱歉" otherButtonTitles: nil ];
        [alertV show];
        [self performSelector:@selector(alertViewBack:) withObject:alertV afterDelay:1.0];
        [alertV release];

    }
    
    BOOL is_clear=YES;   //如果是搜索 那么原来的数据应该清空
    for (NSDictionary *dic in arr) {
        
        ActivityList *activity=[[ActivityList alloc]init];
        [activity setValuesForKeysWithDictionary:dic];
        
        NSNumber *number1=[dicData valueForKey:@"total"];
        activity.total=[NSString stringWithFormat:@"%@",number1];
        NSNumber *number2=[dicData valueForKey:@"cur_page"];
        activity.cur_page=[NSString stringWithFormat:@"%@",number2];
        //计算行程
        int endToStart=[[dic valueForKey:@"end_time"] intValue] - [[dic valueForKey:@"start_time"] intValue];
        activity.allDays=[NSString stringWithFormat:@"行程%d天",endToStart/3600/24];
        if (self.activityArr==nil) {
            self.activityArr=[[NSMutableArray alloc]init];
        }
        
        
        //在此判断是首次加载   下拉刷新   上拉加载
        if (_is_header==0) { //首次加载
            [_activityArr addObject:activity];

        }else if (_is_header==1){//下拉刷新
            BOOL same=NO;
            for(int i=0;i<[_activityArr count];i++){
                ActivityList *action=_activityArr[i];
                if ([action.Id isEqualToString:activity.Id] ) {
                    same=YES;
                    
                    
                }
            }
            if (same==NO) {
                [_activityArr insertObject:activity atIndex:0];
                break;
            }
           
            
        }else if (_is_header==2){ //上拉加载
            [_activityArr addObject:activity];
        }else if(_is_header==3){  //按城市重新搜索
            
            if (is_clear==YES) {
                [_activityArr removeAllObjects];
                is_clear=NO;
            }
            [_activityArr addObject:activity];
        }
    }
    
    [self.listTableView reloadData];

    _is_header=0; //数据请求结束  回至开始状态，无刷新和加载
    [self.listTableView headerEndRefreshing];
    [self.listTableView footerEndRefreshing];
    [self.buffView cancel];
    
    
    
}

-(void)alertViewBack:(UIAlertView*)alertV
{
    [alertV dismissWithClickedButtonIndex:-1 animated:YES];
}
-(void)setNavigaitonBar
{
    
    //动画label
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 10, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:self.title];
    self.navigationItem.titleView = customLab;

    
    self.navigationController.navigationBarHidden=NO;
    //增加下拉按钮  和 搜索按钮
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame=CGRectMake(0, 10, 40, 40);
    [searchBtn addTarget:self action:@selector(searchHandle:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_search_44x44@2x.png"] forState:UIControlStateNormal];
   
    
    UIBarButtonItem *barbutton=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    UIButton *cityBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [cityBtn addTarget:self action:@selector(cityHandle:) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.frame=CGRectMake(0, 20, 25,10);
    [cityBtn setBackgroundImage:[UIImage imageNamed:@"icon_striangle_17x5@2x.png"] forState:UIControlStateNormal];
    [cityBtn setBackgroundImage:[UIImage imageNamed:@"icon_striangle_pressed_17x5@2x.png"] forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barbutton1=[[UIBarButtonItem alloc]initWithCustomView:cityBtn];
    
    self.navigationItem.rightBarButtonItems=@[barbutton,barbutton1];
    
}
#pragma mark --navigationBar 按钮事件--
-(void)cityHandle:(UIButton*)btn
{
    if (self.cityTableV.hidden==YES) {
        self.cityTableV.hidden=NO;
        [self.listTableView addSubview:self.blackView];
        [self.view insertSubview:self.blackView belowSubview:self.cityTableV];
    }else{
        self.cityTableV.hidden=YES;
        [self.blackView removeFromSuperview];
    }
    
}
-(void)searchHandle:(UIButton*)btn
{
    SearchTVController *VC=[[SearchTVController alloc]initWithStyle:UITableViewStylePlain];
    activityListViewController *acVC=self;
    VC.passValue=^(NSString *text){
        //重新拼接网址url
        _is_header=3; //相当于重新请求 
        NSString *str=acVC.urlStr;
        str = [str stringByAppendingString:[NSString stringWithFormat:@"&keywords=%@",text]];
        NSLog(@"%@",str);
        [[RequestHandle alloc]initWithURLString:str  paramString:nil method:@"GET" delegate:self];
        
    };
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:VC];
    navigation.modalPresentationStyle=UIModalPresentationFullScreen;
    navigation.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point=[[touches anyObject] locationInView:self.view];
    if (point.x>220||point.y>280) {
        self.cityTableV.hidden=YES;
        [self.blackView removeFromSuperview];
    }
}
#pragma mark --创建tableView--
-(void)createTableView
{
    self.listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64-49) style:UITableViewStylePlain];
    self.listTableView.dataSource=self;
    self.listTableView.delegate=self;
    [self.listTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"activityListCell"];
    [self.view addSubview: _listTableView];
    //设置缓冲视图
    self.listTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.buffView=[[BufferingView alloc]init];
    [self.view addSubview:_buffView];
    [_buffView start];
    [_listTableView release];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.listTableView) {
        return [_activityArr count];
    }else{
        return [_cityArr count];
    }
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (tableView==self.cityTableV) {
        return @"出发地点";
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.listTableView) {
        return 260;
    }else{
        return 40;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.listTableView) {
        [self.blackView removeFromSuperview];
        self.cityTableV.hidden=YES;
        //传值
        ActivityList *activity=_activityArr[indexPath.row];
        AcDetailVController *detailVC=[[AcDetailVController alloc]init];
        detailVC.activity=activity;
        detailVC.urlId=activity.Id;
        detailVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        detailVC.hidesBottomBarWhenPushed=NO;

    }else if(tableView==self.cityTableV){
        [self.blackView removeFromSuperview];
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        NSArray *cellArr=[tableView visibleCells];
        for (UITableViewCell *cell in cellArr) {
            cell.accessoryView=nil;
        }
        cell.accessoryView=self.accessoryView;
        self.cityTableV.hidden=YES;
        
    
        self.city=[self.cityNumArr objectAtIndex:indexPath.row];
        _is_header=3;
        [self requestData];
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.listTableView) {
        ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityListCell" forIndexPath:indexPath];
        
        ActivityList *activity=[_activityArr objectAtIndex:indexPath.row];
        
        cell.activity=activity;
        [cell.contentView bringSubviewToFront:cell.bg_image ];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
        cell.textLabel.text=[_cityArr objectAtIndex:indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
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
