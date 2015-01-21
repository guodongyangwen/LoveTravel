//
//  DetaiTLViewController.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "DetaiTLViewController.h"
#import "RequestHandle.h"
#import "BufferingView.h"
#import "MJRefresh.h"
@interface DetaiTLViewController ()<RequestHandleDelegate>
@property (nonatomic ,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)int is_refresh;//是刷新（1）还是加载（0）
@property(nonatomic,copy) NSString* cur_page;//当前页(int->string)

@property(nonatomic,retain)NSMutableArray* picSendArray;

@property(nonatomic,retain)NSMutableArray* logdayArray; //日志数组
@property(nonatomic ,retain)BufferingView *bufferView; //加载动画
@property(nonatomic,retain)RequestHandle *request;


@property(nonatomic,copy)NSString* UMUserID;//友盟用户id
@end


@implementation DetaiTLViewController

-(void)dealloc
{
    self.scrollView = nil;
    self.imageView = nil;
    self.tableView = nil;
    self.cur_page = nil;
    //self.picSendArray = nil;
    //self.logdayArray = nil;
    self.bufferView = nil;
    self.detailTL = nil;
    self.travelLog = nil;
    self.logDays = nil;
    self.pictures = nil;
    self.detailData = nil;
    self.dataLogs = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
        self.isAnalysis = NO;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_socialBar updateButtonNumber];
    [_socialBar requestUpdateButtonNumber];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.request cancelConnection];
}

-(void)setTravelLog:(TravelLog *)travelLog
{
    if(_travelLog != travelLog)
    {
        [_travelLog release];
        _travelLog = [travelLog retain];
        //NSLog(@"name:%@",_travelLog.author.nickname);
        self.detailTL  = [[DetailTL alloc] init];
        _detailTL.trailLog = [_travelLog retain];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取用户ID
    [self getUserID];
    
    [self layoutSublayers];
    [self layoutNavigation];
    [self custumizNavigationBar];
    [self layoutSocialBar];
    
    //注册cell
    
    [self.tableView registerClass:[HandViewCell class] forCellReuseIdentifier:@"handCell"];
    
    [self.tableView registerClass:[DetaiTLViewCell class] forCellReuseIdentifier:@"detailTL"];
    
    
    if(self.isAnalysis)//解析数据
    {
        [self analysisData];
    }
    else//请求数据
    {
        //拼接参数
        NSString* urlString = [kDetailTL stringByAppendingFormat:@"%@/log/%@",_travelLog.trail_id,_travelLog.TravelLogId];
        [urlString stringByAppendingString:@"?app_version=2.2.0&device_type=1"];
        
        //请求数据
        [[RequestHandle alloc]initWithURLString:urlString paramString:nil method:@"GET" delegate:self];
        
        //加载动画
        self.bufferView = [[BufferingView alloc]init];
        [self.view addSubview:_bufferView];
        [self.bufferView start];
    }
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

-(void)analysisData
{
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:_dataLogs options:
                             NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *logDic = [dataDic objectForKey:@"log"];
    self.detailTL.source = [[logDic objectForKey:@"source"] copy];
    
    NSArray* logs = [logDic objectForKey:@"log_days"];
    self.logdayArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in logs) {
        logDays* logDay = [[logDays alloc] init];
        [logDay setValuesForKeysWithDictionary:dic];
        [self.logdayArray addObject:logDay];
    }
    
    //处理日志数组
    self.picSendArray = [[NSMutableArray alloc] init];
    for (logDays* logDay in _logdayArray) {
        NSArray* arrPic = [logDay pictureArr];
        for (Picture* pic in arrPic) {
            [self.picSendArray addObject:pic];
        }
    }
    
    //加载数据
    [self.tableView reloadData];
    [self layoutSocialBar];
}

-(void)layoutNavigation
{
    UIButton *leftBtn=[UIButton buttonWithType: UIButtonTypeSystem];
    leftBtn.frame=CGRectMake(0, 0, 20, 20);
    [leftBtn addTarget:self action:@selector(backListView) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_back_33x44@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
-(void)backListView
{
    [self.navigationController popViewControllerAnimated:YES];
}
//请求数据
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    
    self.detailData = [NSData data];
    self.detailData = data;
   
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:
        NSJSONReadingMutableContainers error:nil];
   
    NSDictionary *logDic = [dataDic objectForKey:@"log"];
    self.detailTL.source = [[logDic objectForKey:@"source"] copy];
    
    NSArray* logs = [logDic objectForKey:@"log_days"];
    self.logdayArray = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in logs) {
        logDays* logDay = [[logDays alloc] init];
        [logDay setValuesForKeysWithDictionary:dic];
        [self.logdayArray addObject:logDay];
    }
    
    //处理日志数组
    self.picSendArray = [[NSMutableArray alloc] init];
    for (logDays* logDay in _logdayArray) {
        NSArray* arrPic = [logDay pictureArr];
        for (Picture* pic in arrPic) {
            [self.picSendArray addObject:pic];
        }
    }
    
    //加载数据
    [self.tableView reloadData];
    [self.bufferView cancel];
    
}

#pragma mark --设置社会化组件--
-(void)layoutSocialBar
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:self.travelLog.name];
    _socialBar = [[UMSocialBar alloc] initWithUMSocialData:socialData withViewController:self];
    //下面设置回调对象，如果你不需要得到回调方法也可以不设置
    _socialBar.socialUIDelegate = self;
    
    //自定义socialBar
    [self customSocialBar];
    
    _socialBar.center = CGPointMake(size.width/2, size.height - 89);
    [self.view addSubview:_socialBar];
    
    
}
#pragma mark --自定义socialBar--
-(void)customSocialBar
{
    
    [_socialBar.barButtons removeObjectAtIndex:3];
    [_socialBar.barButtons removeObjectAtIndex:0];
    
    
    UMSocialData *socialData=[[UMSocialData alloc]initWithIdentifier:self.travelLog.TravelLogId];
    //设置分享文字和图片
    socialData.shareText=@"爱上旅行，爱上自由";
    socialData.shareImage=[UIImage imageNamed:@"introduce1.jpg"];
    
    //设置评论文字和图片
    socialData.commentText=@"爱上旅行，一路相随";
    socialData.commentImage=[UIImage imageNamed:@"introduce1.jpg"];
    
    UMSocialButton *customButton = [[UMSocialButton alloc] initWithButtonName:@"collect" socialData:socialData controller:self];
    customButton.clickHandler = ^(){
        [self collectHandle:customButton];
        
    };
    [customButton setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    [_socialBar.barButtons addObject:customButton];
    
    
   
    
    /*
    UMSocialButton *btn = [_socialBar.barButtons objectAtIndex:1];
    btn.clickHandler=^(){  //点击分享按钮  按照用户已登录账户跳转到相应平台的编辑页面
        //获取登录信息
        NSDictionary *dic=[UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity *qqEntity=[dic valueForKey:UMShareToQzone ];
        UMSocialAccountEntity *sinaEntity=[dic valueForKey:UMShareToSina];
        
        NSString *qqName=qqEntity.userName;
        NSString *sinaName=sinaEntity.userName;
        
        UMSocialControllerService *controlSerVice=[[UMSocialControllerService alloc]initWithUMSocialData:socialData];
        
        UIViewController *VC=nil;
        
        if (qqName) { //获取qq编辑页面
            VC = [controlSerVice getSocialViewController:UMSViewControllerShareEdit withSnsType:UMShareToQzone];
        }else if (sinaName){  //获取sina编辑页面
            VC = [controlSerVice getSocialViewController:UMSViewControllerShareEdit withSnsType:UMShareToSina];
        }else{ //如果都没有登录  跳出UMServiceSns
            [UMSocialSnsService presentSnsController:self appKey:@"5450da62fd98c5be2802345f" shareText:@"爱上旅行，爱上自由" shareImage:[UIImage imageNamed:@"introduce1.jpg"] shareToSnsNames:@[UMShareToQzone,UMShareToSina] delegate:nil ];
            
        }
        
        
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:VC];
        navigation.modalPresentationStyle=UIModalPresentationFullScreen;
        navigation.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:navigation animated:YES completion:nil];
        
    };
     */
    
}

#pragma mark --收藏处理--
-(void)collectHandle:(UIButton*)btn
{
    
    [self getUserID];
    
    if(_UMUserID)//已经登录
    {
        
       if([[[FileManager sharedFileManager] querryTrailLogDataFromDBWithuserID:_UMUserID Id:_detailTL.trailLog.TravelLogId] isEqualToString:_detailTL.trailLog.TravelLogId])
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"该活动已被收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            [alert performSelectorOnMainThread:@selector(dismissWithClickedButtonIndex:animated:) withObject:self waitUntilDone:YES];
        }
        else//进行收藏
        {
            //收藏处理
            //NSLog(@"name:%@",_travelLog.author.nickname);
            NSDictionary* dic = @{
                                  @"TravelLogId":_travelLog.TravelLogId,
                                  @"cover":_travelLog.cover,
                                  @"start_date":_travelLog.start_date,
                                  @"total_days":_travelLog.total_days,
                                  @"photo_number":_travelLog.photo_number,
                                  @"destination":_travelLog.destination,
                                  @"name":_travelLog.name,
                                  @"nickname":_travelLog.author.nickname,
                                  @"avatar":_travelLog.author.avatar};
            
            

            [[FileManager sharedFileManager] saveTrailLogDetailWithuserID:_UMUserID TrailLogId:_travelLog.TravelLogId TrailLog:_detailData trailDetail:dic];
            
            
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            [alert performSelectorOnMainThread:@selector(dismissWithClickedButtonIndex:animated:) withObject:self waitUntilDone:YES];
        }

    }
    else//没有登录，提示登录
    {
        UIActionSheet* actionS = [[UIActionSheet alloc] initWithTitle:@"用户登录" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        
        //添加按钮
        [actionS addButtonWithTitle:@"新浪登录"];
        [actionS addButtonWithTitle:@"QQ登录"];
        [actionS addButtonWithTitle:@"取消"];
        actionS.cancelButtonIndex = actionS.numberOfButtons  - 1;
        [actionS showFromTabBar:self.tabBarController.tabBar];
        //设置代理
        actionS.delegate = self;
    }
}

//实现actionSheet代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)//新浪登录
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          //登录完成   直接进行收藏
                                          [self collectHandle:nil];
                                      });

    }
    else if(buttonIndex == 1)//QQ登录
    {
        [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
        
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          [self collectHandle:nil];
                                      });
        
        
        
    }
    
}


//实现QQ登录完成代理方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //[self collectHandle:nil];
}



-(void)layoutSublayers
{
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 455)style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
}

//自定义导航条
-(void)custumizNavigationBar
{
    //动画label
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 10, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:self.travelLog.name];
    self.navigationItem.titleView = customLab;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.logdayArray.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    return [[[self.logdayArray objectAtIndex:(section -1)] pictureArr] count];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
    HandViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"handCell" forIndexPath:indexPath];
        //赋值
        
        //cell.detailTL = self.detailTL;
        _travelLog.author.nickname = _travelLog.nickname;
        _travelLog.author.avatar = _travelLog.avatar;
        cell.travelLog = self.travelLog;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    else
    {
    
       DetaiTLViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailTL" forIndexPath:indexPath];
       //赋值

        cell.pictures = [[[self.logdayArray objectAtIndex:(indexPath.section-1)] pictureArr] objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return nil;
    }
    
   return [[self.logdayArray objectAtIndex:(section-1)] trail_day];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        
        return 300;
    }
    //设置对应的行高
    Picture *pic = [[[self.logdayArray objectAtIndex:(indexPath.section-1)] pictureArr] objectAtIndex:indexPath.row];
    return  240 +[DetaiTLViewCell getHighWithString:pic.description];
}

//section的线
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return;
    }
    //创建UICollectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+20);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    PictureViewController *picVC = [[PictureViewController alloc]initWithCollectionViewLayout:layout];
    
   
    
    
    
    //传值
    picVC.titleNB = _travelLog.name;

    picVC.pictureArr = self.picSendArray;

    NSInteger index = 0;
    for (int i=0;i<indexPath.section-1;i++) {
        logDays* logDay = [_logdayArray objectAtIndex:(i)];
        index += [[logDay pictureArr] count];
        
    }
    index += indexPath.row;
    

    picVC.current_index = [NSIndexPath indexPathForItem:index inSection:0];
    //NSLog(@"indexpath :%@",picVC.current_index);
    
    picVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:picVC animated:YES];
    picVC.hidesBottomBarWhenPushed = NO;

    [picVC release];
        

}


@end
