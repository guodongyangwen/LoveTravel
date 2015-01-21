//
//  TrailDetailViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TrailDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+HeightHandle.h"

#define identifier @"collectionViewCell"
#define identifier_cover @"cover"

@interface TrailDetailViewController ()
{
    dispatch_queue_t queue;
}

//data

@property(nonatomic,retain)UITapGestureRecognizer* tap;
@property(nonatomic,retain)UITapGestureRecognizer* tap2;
@property(nonatomic,retain)TrailDetail* trailDetail;
@property(nonatomic,retain)NSMutableArray* commentArr;
@property(nonatomic,retain)NSMutableArray* relativeTrailsArr;
//数据请求
@property(nonatomic,retain)RequestHandle* detailRequestHandle;//详情请求
@property(nonatomic,retain)RequestHandle* scoreRequestHandle;//评论请求
@property(nonatomic,retain)RequestHandle* relativeTrailsRequestHandle;//先关路线请求
@property(nonatomic,copy)NSString* totalScore;//评论总数
@property(nonatomic,assign)CGFloat height_comment;


//布局
@property(nonatomic,retain)UIScrollView* scrollView;//底部scrollview，因为页面是滚动的
@property(nonatomic,retain)UICollectionView* traitCV;//特征CV
@property(nonatomic,retain)UILabel* label_name;//路线名称
@property(nonatomic,retain)UIImageView* imageV_destination;//目的地图片
@property(nonatomic,retain)UILabel* label_destination;//目的地
@property(nonatomic,retain)UILabel* label_detail;//路线介绍

@property(nonatomic,retain)UILabel* label_Crowd;//适合人群

@property(nonatomic,retain)CrowdView* crowdView;//帮助视图

@property(nonatomic,retain)UILabel* label_container1;//驴友评价  总结 视图容器

@property(nonatomic,assign)CGFloat height_detail;//详情高度


@property(nonatomic,retain)UICollectionView* pictureCV;//图片collectionView

@property(nonatomic,retain)BufferingView* buffView;//缓冲动画



@property(nonatomic,copy)NSString* UMUserID;//UM用户ID
@end

@implementation TrailDetailViewController




-(void)dealloc
{
    self.trailId = nil;
    self.titleNB = nil;
    self.dataArr = nil;
    self.dataComment = nil;
    self.dataDetail  = nil;
    self.dataRelative = nil;
    self.UMUserID = nil;
    self.buffView = nil;
    self.pictureCV = nil;
    self.label_container1 = nil;
    self.label_Crowd = nil;
    self.label_destination = nil;
    self.label_detail = nil;
    self.label_name = nil;
    self.trailDetail=nil;
    self.commentArr=nil;
    self.relativeTrailsArr=nil;
    //数据请求
    self.detailRequestHandle=nil;//详情请求
    self.scoreRequestHandle=nil;//评论请求
    self.relativeTrailsRequestHandle=nil;//先关路线请求
    self.totalScore=nil;//评论总数
    
    
    //布局
    self.scrollView=nil;//底部scrollview，因为页面是滚动的
    self.traitCV=nil;//特征CV
    self.imageV_destination=nil;//目的地图片
    
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.isRequest = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //刷新数据
    [_socialBar requestUpdateButtonNumber];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self customizeNB];
    [self layoutScrollView];
    [self getUserID];
    
    
    if(_isRequest == NO)//从数据库中解析
    {
        [self analysisData];
    }
    else
    {
        [self addActivityIndicator];
        [self requestData];
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

//添加加载控件
-(void)addActivityIndicator
{
    
    self.buffView  = [[BufferingView alloc] init];
    [self.view addSubview:_buffView];
    [_buffView start];
    
    
}

//设置scrollview
-(void)layoutScrollView
{
    //************************************************************底部scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 504)];
   
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(320, 1000);
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    
    
}

//自定义NB
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
}

//请求数据
-(void)requestData
{
        //*******************************************路线详情数据请求
        //路线详情  对象
        self.trailDetail = [[TrailDetail alloc] init];
        //拼接URL字符串
        NSString* detailURLString = [kTrailDetail_lostId stringByAppendingString:_trailId];
        detailURLString = [detailURLString stringByAppendingString:@"?&access_token=9c659546-c684-43c0-8f4a-7feeb8ce400f&app_version=2.2.0&device_type=1"];
        detailURLString = [detailURLString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",detailURLString);
        self.detailRequestHandle = [[RequestHandle alloc] initWithURLString:detailURLString paramString:nil method:@"GET" delegate:self];

    

        //**************************************************************路线评论数据请求
        //创建数组
        self.commentArr = [[NSMutableArray alloc] initWithCapacity:2];
        //拼接URL
        NSString* scoreURLString = [kTrailDetail_lostId stringByAppendingString:_trailId];
        scoreURLString = [scoreURLString stringByAppendingString:@"/score"];
        scoreURLString = [scoreURLString stringByAppendingString:@"?app_version=2.2.0&device_type=2&page=1&page_size=1&access_token=9c659546-c684-43c0-8f4a-7feeb8ce400f"];
        //NSLog(@"url_comment:%@",scoreURLString);
        self.scoreRequestHandle = [[RequestHandle alloc] initWithURLString:scoreURLString paramString:nil method:@"GET" delegate:self];
        //**************************************************************相关路线数据请求
        //创建数组
    self.relativeTrailsArr = [[NSMutableArray alloc] init];
    //拼接URL
    NSString* relativeTrailsURLString = [kTrailDetail_lostId stringByAppendingFormat:@"related/%@",_trailId];
    relativeTrailsURLString = [relativeTrailsURLString stringByAppendingString:@"?app_version=2.2.0&device_type=1"];
    //NSLog(@"url:%@",relativeTrailsURLString);
    self.relativeTrailsRequestHandle = [[RequestHandle alloc] initWithURLString:relativeTrailsURLString paramString:nil method:@"GET" delegate:self];
}


-(void)setDataDetail:(NSData *)dataDetail
{
    if(_dataDetail != dataDetail)
    {
        [_dataDetail release];
        _dataDetail = [dataDetail retain];
    }
}

-(void)setDataComment:(NSData *)dataComment
{
    if(_dataComment != dataComment)
    {
        [_dataComment release];
        _dataComment = [dataComment retain];
    }
}

-(void)setDataRelative:(NSData *)dataRelative
{
    if(_dataRelative != dataRelative)
    {
        [_dataRelative release];
        _dataRelative = [dataRelative retain];
    }
}

#pragma mark 数据解析
-(void)analysisData
{
    //**********************************************详情
    NSDictionary* dicDetail = [NSJSONSerialization JSONObjectWithData:_dataDetail options:NSJSONReadingAllowFragments error:nil];
        //调用kvc  封装对象 并 赋值
    self.trailDetail = [[TrailDetail alloc] init];
        [_trailDetail setValuesForKeysWithDictionary:dicDetail];
    //**********************************************评论
    NSDictionary* dicComment = [NSJSONSerialization JSONObjectWithData:_dataComment options:NSJSONReadingAllowFragments error:nil];
    
    
    self.commentArr = [[NSMutableArray alloc] init];
        //总评论数
        self.totalScore = [dicComment objectForKey:@"total"];
        //解析数据
        NSArray* comments = [dicComment objectForKey:@"comments"];
        for (NSDictionary* comDic in comments)
        {
            CommentModal* c = [[CommentModal alloc] init];
            [c setValuesForKeysWithDictionary:comDic];
            //NSLog(@"user:%@",c.auther);
            [_commentArr addObject:c];
        }
    
    //**********************************************相关路线
    NSDictionary* dicRelative = [NSJSONSerialization JSONObjectWithData:_dataRelative options:NSJSONReadingAllowFragments error:nil];
    self.relativeTrailsArr = [[NSMutableArray alloc] init];
        NSArray* relative = [dicRelative objectForKey:@"trails"];
        for (NSDictionary* dic in relative)
        {
            Trail* trail = [[Trail alloc] init];
            [trail setValuesForKeysWithDictionary:dic];
            [self.relativeTrailsArr addObject:trail];
        }
    
    
    
        [self layoutSubviews];
        [self layoutSocialBar];
    [_socialBar updateButtonNumber];
   


    
}

#pragma mark  数据请求处理
//请求数据成功
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
    if(requestHandle == _detailRequestHandle)//详情数据
    {
        NSError* err = nil;
        self.dataDetail = data;
        
        NSDictionary* dicWide = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err)
        {
            NSLog(@"数据请求错误:%@",err);
        }
        else if(!err && !data)
        {
            NSLog(@"请求数据没错，但是也没有请求到数据");
        }
        else//请求数据成功
        {
            //调用kvc  封装对象 并 赋值
            [_trailDetail setValuesForKeysWithDictionary:dicWide];
            
        }
        
    }
    else if(requestHandle == _scoreRequestHandle)//评论数据
    {
        self.dataComment = data;
        
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
            //总评论数
            self.totalScore = [dicWide objectForKey:@"total"];
            //解析数据
            NSArray* comments = [dicWide objectForKey:@"comments"];
            for (NSDictionary* comDic in comments) {
                CommentModal* c = [[CommentModal alloc] init];
                [c setValuesForKeysWithDictionary:comDic];
                //NSLog(@"user:%@",c.auther);
                [_commentArr addObject:c];
            }
            
        }
    }
    else if(requestHandle == _relativeTrailsRequestHandle)//先关路线请求
    {
        
        self.dataRelative = data;
        
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
            NSArray* relative = [dicWide objectForKey:@"trails"];
            for (NSDictionary* dic in relative)
            {
                Trail* trail = [[Trail alloc] init];
                [trail setValuesForKeysWithDictionary:dic];
                [self.relativeTrailsArr addObject:trail];
            }
            
        }
    }
    
    if(_trailDetail.name && [_commentArr count]!= 0 && _relativeTrailsArr.count != 0)
    {
        //NSLog(@"---%@",[_commentArr objectAtIndex:0]);
        //获取数据后，布局 子视图
        
        [self layoutSubviews];
        [self layoutSocialBar];
        [_buffView removeFromSuperview];
    }
    
    
}

//请求数据失败
-(void)requestHandle:(RequestHandle *)requestHandle requestFailedWithError:(NSError *)error
{
    //取消连接
    if(requestHandle == _detailRequestHandle)
    {
        [_detailRequestHandle cancelConnection];
    }
    else if(requestHandle == _scoreRequestHandle)
    {
        [_scoreRequestHandle cancelConnection];
    }
    else if(requestHandle == _relativeTrailsRequestHandle)
    {
        [_relativeTrailsRequestHandle cancelConnection];
    }
}

-(void)layoutSocialBar
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:self.titleNB];
    _socialBar = [[UMSocialBar alloc] initWithUMSocialData:socialData withViewController:self];
    //下面设置回调对象，如果你不需要得到回调方法也可以不设置
    _socialBar.socialUIDelegate = self;
    
    //自定义socialBar
    [self customSocialBar];
    
    _socialBar.center = CGPointMake(size.width/2, size.height - 90);
    [self.view addSubview:_socialBar];
    

}
#pragma mark --自定义socialBar--
-(void)customSocialBar
{
    
    
    [_socialBar.barButtons removeObjectAtIndex:3];
    //删除评论按钮
    [_socialBar.barButtons removeObjectAtIndex:0];
    
    //********************************************************分享内容
    //每一个bar都有一个socialData  ，标识使用   名称
    UMSocialData *socialData=[[UMSocialData alloc]initWithIdentifier:self.titleNB];
    //设置分享内容
    socialData.shareText = @"爱上旅行，爱上自由";
    //NSLog(@"URL:%@",_trailDetail.cover);
    socialData.shareImage = [UIImage imageNamed:@"introduce1.jpg"];
    
    //********************************************************收藏按钮
    UMSocialButton *customButton = [[UMSocialButton alloc] initWithButtonName:@"collect" socialData:socialData controller:self];
    [customButton setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    customButton.clickHandler = ^(){
        [self collectHandle:customButton];
        
    };
    [_socialBar.barButtons addObject:customButton];
    
    //********************************************************分享按钮
    //自定义
    //UMSocialButton* btnShare = [_socialBar.barButtons objectAtIndex:1];
    /*btnShare.clickHandler = ^(){
        {
        //点击分享按钮  按照用户已登录账户跳转到相应平台的编辑页面
        //获取登录信息
        NSDictionary* dic = [UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity* QQAccount = [dic objectForKey:UMShareToQzone];
        UMSocialAccountEntity* SinaAccount = [dic objectForKey:UMShareToSina];
        
        NSString* QQName = QQAccount.userName;
        NSString* SinaName = SinaAccount.userName;
        
        UMSocialControllerService* controlService = [[UMSocialControllerService alloc] initWithUMSocialData:[[UMSocialData alloc] initWithIdentifier:self.titleNB]];
        UIViewController* VC = nil;
        if(QQName)//QQ登录
        {
            VC = [controlService getSocialViewController:UMSViewControllerShareEdit withSnsType:UMShareToQzone];
        }
        else if(SinaName)//新浪登录
        {
            VC = [controlService getSocialViewController:UMSViewControllerShareEdit withSnsType:UMShareToSina];
            
        }
        else//都没登录
        {
            [UMSocialQQHandler setSupportWebView:YES];
            [UMSocialSnsService presentSnsController:self appKey:@"5450da62fd98c5be2802345f" shareText:@"爱上旅行，爱上自由" shareImage:[UIImage imageNamed:@"introduce1.jpg"] shareToSnsNames:@[UMShareToQzone,UMShareToSina] delegate:nil];
        }
        
        
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:VC];
        navigation.modalPresentationStyle=UIModalPresentationFullScreen;
        navigation.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:navigation animated:YES completion:nil];
        }
    
    };*/
    
    
}
#pragma mark --收藏处理--
-(void)collectHandle:(UIButton*)btn
{
    [self getUserID];
    
    if(_UMUserID)//登录过了
    {
        //收藏操作
        [DataBaseManager openDataBase];
        //判断是否收藏过了
        if([[[FileManager sharedFileManager] querryTrailDetailWithUserID:_UMUserID TrailId:_trailId] isEqualToString:_trailId] == YES)
        {
            UIAlertView* alert  = [[UIAlertView alloc] initWithTitle:nil message:@"已收藏该路线" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1.3];
        }
        else
        {
//            [[FileManager sharedFileManager] saveTrailDetailWithTrailIntroduceId:_trailId TrailIntroduce:self.dataDetail TrailComment:self.dataComment TrailOtherTrail:self.dataRelative];
            [[FileManager sharedFileManager] saveTrailDetailWithUserID:_UMUserID TrailIntroduceId:_trailId TrailIntroduce:self.dataDetail TrailComment:self.dataComment TrailOtherTrail:self.dataRelative];
            
            UIAlertView* alert  = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:self afterDelay:1.3];
        }

    }
    else//提示登录
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
    //设置代理方法，登录完成后  执行（QQ登录)
    
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
        
        [UMSocialQQHandler setSupportWebView:YES];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                          {
                                              //登录完成   直接进行收藏
                                              [self collectHandle:nil];
                                          });
    }
    
    
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //QQ登录之后进行收藏
            //[self collectHandle:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.detailRequestHandle cancelConnection];
    [self.scoreRequestHandle cancelConnection];
    [self.relativeTrailsRequestHandle cancelConnection];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//布局子视图
-(void)layoutSubviews
{
    
    
    //***********************************************************************************图片轮播图

    
    //流水布局
    UICollectionViewFlowLayout* layout_picture = [[UICollectionViewFlowLayout alloc] init];
    layout_picture.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //集合视图
    self.pictureCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, 150) collectionViewLayout:layout_picture];
    
    layout_picture.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 149);
    layout_picture.minimumLineSpacing = 0;
    layout_picture.sectionInset =  UIEdgeInsetsMake(0, 0, 0, 0);
    
    //属性
    _pictureCV.backgroundColor = [UIColor lightGrayColor];
    _pictureCV.showsHorizontalScrollIndicator = NO;
    _pictureCV.pagingEnabled = YES;
    _pictureCV.userInteractionEnabled = YES;
    _pictureCV.tag = 101;
    //设置代理
    _pictureCV.dataSource = self;
    _pictureCV.delegate = self;
    //添加到scrollview
    [_scrollView addSubview:_pictureCV];
    
    //释放
    [_pictureCV release];
    [layout_picture release];
    
    //注册一个cell
    [_pictureCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier_cover];
    
    
    
    //***********************************************************************************路线特征 CV
    //设置流水布局
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(60, 50);
    
    self.traitCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, 320, 60) collectionViewLayout:flowLayout];
    //属性
    _traitCV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    _traitCV.showsHorizontalScrollIndicator = NO;
    _traitCV.contentSize = CGSizeMake(500, 60);
    _traitCV.scrollEnabled = YES;
    _traitCV.tag = 102;
    //设置数据源和代理
    _traitCV.dataSource = self;
    _traitCV.delegate = self;
    [_scrollView addSubview:_traitCV];
    [_traitCV release];
    [flowLayout release];
    //注册一个cell
    [_traitCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //***********************************************************************************路线详情
    //路线名称
    self.label_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 200, 40)];
    _label_name.text = _trailDetail.name;
    _label_name.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:_label_name];
    [_label_name release];
    
    
    //路线目的地
    //图片
    self.imageV_destination = [[UIImageView alloc] initWithFrame:CGRectMake(10, 260, 12, 12)];
    _imageV_destination.image = [UIImage imageNamed:@"icon_location_gray_12x12@2x"];
    [_scrollView addSubview:_imageV_destination];
    [_imageV_destination release];
    
    
    //目的地
    self.label_destination = [[UILabel alloc] initWithFrame:CGRectMake(25, 258, 200, 15)];
    _label_destination.font = [UIFont systemFontOfSize:10.f];
    _label_destination.text = _trailDetail.destination;
    [_scrollView addSubview:_label_destination];
    [_label_destination release];
    
    //详情介绍
    //获取文本高度
    self.height_detail = [NSString getHeightWithText:_trailDetail.detail ViewWidth:300 fontSize:13];
    
    self.label_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 300, _height_detail)];
    _label_detail.font = [UIFont fontWithName:nil size:13];
    _label_detail.numberOfLines = 0;
    
    _label_detail.text = _trailDetail.detail;
    [_scrollView addSubview:_label_detail];
    [_label_detail release];
    
   
    //***********************************************************************************适合人群
    //适合人群标签
    self.label_Crowd = [[UILabel alloc] initWithFrame:CGRectMake(10, 310+_height_detail, 200, 40)];
    _label_Crowd.font = [UIFont systemFontOfSize:18];
    _label_Crowd.text = @"适合人群";
    [_scrollView addSubview:_label_Crowd];
    [_label_Crowd release];
    
    //一条灰线
    UILabel* label_gray = [[UILabel alloc] initWithFrame:CGRectMake(0, 349+_height_detail, 320, 1)];
    label_gray.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:label_gray];
    [label_gray release];
    
    //适合人群 按钮
    for(int i=0;i<_trailDetail.crowdArr.count;i++)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //设置属性
        button.layer.cornerRadius = 6;
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_crowd_button.png"]];
        NSString* title = [[_trailDetail.crowdArr objectAtIndex:i] name];
        title  = [title stringByAppendingFormat:@"+ %@",[[_trailDetail.crowdArr objectAtIndex:i] crowd_count]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(10+90*(i%3), 360+_height_detail+35*(i/3), 80, 25);
        //添加事件
        [button addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    
    
    //开始 的y 坐标
    CGFloat y_comment_start = 370 + _height_detail +((([_trailDetail.crowdArr count] - 1)/3)+1)*35;
    self.label_container1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y_comment_start, 320, 50)];
    _label_container1.userInteractionEnabled = YES;
    _label_container1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [_scrollView addSubview:_label_container1];
    [_label_container1 release];
    
    UILabel* label_score = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 40)];
    label_score.text = @"驴友评价";
    //label_score.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trail_font_colore"]];
    label_score.font = [UIFont systemFontOfSize:15];
    [_label_container1 addSubview:label_score];
    [label_score release];
    
    
    //星星
    [self setScore:_trailDetail.trail_score];
    //评分
    UILabel* label_s = [[UILabel alloc] initWithFrame:CGRectMake(180, 15, 30, 20)];
    label_s.font = [UIFont systemFontOfSize:13];
    label_s.text = [NSString stringWithFormat:@"%@",_trailDetail.trail_score];
    [_label_container1 addSubview:label_s];
    [label_s release];

    #pragma mark   评论布局
    //总共多少条评论
    //按钮
    UIView *viewTotalComment = [[UIView alloc] initWithFrame:CGRectMake(230, 0, 80, 50)];
    viewTotalComment.userInteractionEnabled = YES;
    [_label_container1 addSubview:viewTotalComment];
    //按钮上添加字体
    NSString *commnt_count = _totalScore;//总评论数
    NSString* str_totalComment = [NSString stringWithFormat:@"全部%@评价",commnt_count];
    UIButton* button_totalComment = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button_totalComment.frame =CGRectMake(0, 15, 60, 20);
    button_totalComment.titleLabel.font = [UIFont systemFontOfSize:13];
    button_totalComment.userInteractionEnabled = YES;
    [button_totalComment addTarget:self action:@selector(totalComment) forControlEvents:UIControlEventTouchUpInside];
    [button_totalComment setTitle:str_totalComment forState:UIControlStateNormal];
    [viewTotalComment addSubview:button_totalComment];
    
    
    UIButton* button_totalC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button_totalC.frame = CGRectMake(60, 18, 10, 15);
    [button_totalC addTarget:self action:@selector(totalComment) forControlEvents:UIControlEventTouchUpInside];
    button_totalC.userInteractionEnabled = YES;
    [button_totalC setBackgroundImage:[UIImage imageNamed:@"icon_arrow_8x13@2x"] forState:UIControlStateNormal];
    [viewTotalComment addSubview:button_totalC];
    
    NSMutableArray* heigtCommentArr = [NSMutableArray array];
    for (CommentModal* com in _commentArr) {
        CGFloat height  = [NSString getHeightWithText:[com comment] ViewWidth:300 fontSize:15];
        [heigtCommentArr addObject:[NSNumber numberWithFloat:height]];
    }
    
    
    for(int i=0;i<_commentArr.count;i++)
    {
            //评论
            CommentModal* com1 = [_commentArr objectAtIndex:i];
            //自适应高度
            self.height_comment  = [NSString getHeightWithText:[[_commentArr objectAtIndex:0] comment] ViewWidth:300 fontSize:15];
            CustomizeCommentView* commentView1 = [[CustomizeCommentView alloc] initWithFrame:CGRectMake(0, y_comment_start+51 + (85+self.height_comment)*i, 320, 85+[[heigtCommentArr objectAtIndex:i] floatValue])];
            commentView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
            
            //赋值
            commentView1.comment = com1;
            //添加轻拍事件
            UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcom1:)];
            [commentView1 addGestureRecognizer:tap1];
            [tap1 release];
            
            
            [_scrollView addSubview:commentView1];
            [commentView1 release];
            
            //灰线
            UILabel* label_gray2 = [[UILabel alloc] initWithFrame:CGRectMake(0, y_comment_start+51+85+_height_comment, 320, 1)];
            label_gray2.backgroundColor = [UIColor lightGrayColor];
            [_scrollView addSubview:label_gray2];
            [label_gray2 release];

    }
   
    
    
    
    
    
    //计算  相关路线的  y坐标
    y_comment_start = y_comment_start + 52 + 15;
    for(int i=0;i<_commentArr.count;i++)
    {
        
        y_comment_start = y_comment_start + 85 + [[heigtCommentArr objectAtIndex:i] floatValue];
    }
    
    
    
#pragma mark 布局相关路线
    //相关路线标签
    UILabel* label_related_trail = [[UILabel alloc] initWithFrame:CGRectMake(10, y_comment_start, 200, 40)];
    label_related_trail.text = @"相关路线";
    label_related_trail.font = [UIFont systemFontOfSize:18];
    [_scrollView addSubview:label_related_trail];
    [label_related_trail release];
    
    //先关路线封面
    int i=0;
    for (Trail* trail in _relativeTrailsArr) {
        CustomizeTrailCoverView* relativeTrail = [[CustomizeTrailCoverView alloc] initWithFrame:CGRectMake(20+100*i, y_comment_start+50, 80, 80)];
        //设置数据
        relativeTrail.trail = trail;
        //添加手势
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trailHandle:)];
        [relativeTrail addGestureRecognizer:tap];
        [tap release];
        
        [_scrollView addSubview:relativeTrail];
        [relativeTrail release];
        
        i = i + 1;
    }
    
    
    
    //修改scrollview 的contentsize
    _scrollView.contentSize = CGSizeMake(320, y_comment_start + 200);
    
    
    
    self.crowdView = [[CrowdView alloc] initWithFrame:CGRectMake(320, 0, 260, 504)];
    //传值
    //NSLog(@"------%@",_trailDetail.crowdArr);
    self.crowdView.crowdArr = _trailDetail.crowdArr;
    _crowdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_crowdView];
    
}

-(void)hide:(UITapGestureRecognizer*)tap
{
    
    if(_crowdView.center.x == 190)
    {
        //设置动画
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
        animation.autoreverses = NO;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
        animation.duration = 0.4;
        [_crowdView.layer addAnimation:animation forKey:@"position"];
        _crowdView.center = CGPointMake(450, 252);
        
        //删除的时候，一闪而过，
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_crowdView removeFromSuperview];
//        });

        [_scrollView removeGestureRecognizer:_tap];
        [_crowdView removeGestureRecognizer:_tap2];
    }
    
}


#pragma mark 点击相关路线处理
-(void)trailHandle:(UITapGestureRecognizer *)tap
{
    Trail* trail  = ((CustomizeTrailCoverView*)tap.view).trail;
    TrailDetailViewController* trailDetailVC = [[TrailDetailViewController alloc] init];
    trailDetailVC.trailId = trail.Id;
    trailDetailVC.titleNB = trail.name;
    [self.navigationController pushViewController:trailDetailVC animated:YES];
    [trailDetailVC release];
}

#pragma mark  查看所有评论

-(void)clickcom1:(UITapGestureRecognizer*)tap
{
    [self totalComment];
}

-(void)totalComment
{
    //跳转到所有评论页面
    //SLog(@"查看所有评论");
    CommentTViewController* commentVC = [[CommentTViewController alloc] init];
    //路线id
    commentVC.trailId = _trailDetail.Id;
    commentVC.commentTrail = _trailDetail.name;//路线名称
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
    [commentVC release];
}

//设置评分
-(void)setScore:(NSString *)score
{
    float s = score.floatValue;
    if(s>9)//五颗星
    {
        for(int i=0;i<5;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 15, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [_label_container1 addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>8 && s<=9)//四星半
    {
        for(int i=0;i<5;i++)
        {
            if(i==4)
            {
                UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 15, 20, 20)];
                imageView.image = [UIImage imageNamed:@"img_star_half_14x14@2x"];
                [_label_container1 addSubview:imageView];
                [imageView release];
                break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 15, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [_label_container1 addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>7 && s<=8)//四星
    {
        for(int i=0;i<4;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 15, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [_label_container1 addSubview:imageView];
            [imageView release];
        }
        
    }
}

//适合人群 按钮点击事件
-(void)btnHandle:(UIButton*)btn
{
    
    
    if(_crowdView.center.x == 190)
    {
        //设置动画
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
        animation.autoreverses = NO;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
        animation.duration = 0.4;
        [_crowdView.layer addAnimation:animation forKey:@"position"];
        _crowdView.center = CGPointMake(450, 252);
        
        //删除的时候，一闪而过，
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_crowdView removeFromSuperview];
//        });
        [self.scrollView removeGestureRecognizer:_tap];
        [self.crowdView removeGestureRecognizer:_tap2];
        
    }
    else
    {
        //添加手势
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide:)];
        [_scrollView addGestureRecognizer:_tap];
        [_tap release];
        
        
        //添加手势
        self.tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        [_crowdView addGestureRecognizer:_tap2];
        [_tap2 release];
        
        //设置动画
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
        animation.autoreverses = NO;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
        animation.duration = 0.4;
        [_crowdView.layer addAnimation:animation forKey:@"position"];
        _crowdView.center = CGPointMake(190, 252);
    }
    
    
}

//手势事件处理
-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    //设置动画
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
    animation.autoreverses = NO;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
    animation.duration = 0.4;
    [_crowdView.layer addAnimation:animation forKey:@"position"];
    _crowdView.center = CGPointMake(450, 252);
    
    
    [_crowdView removeGestureRecognizer:_tap2];
    [_scrollView removeGestureRecognizer:_tap];
    
    //删除的时候，一闪而过，
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [_crowdView removeFromSuperview];
//    });
    
    //[];
}

#pragma mark collectionView代理
//区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 101)//图片
    {
        //NSLog(@"count:%ld",[_trailDetail.pictureArr count]);
        return [_trailDetail.pictureArr count];
    }
    else if(collectionView.tag == 102)//特征
    {
        return [self.trailDetail.traitArr count];
    }
    return 0;
}
//设置cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 101)
    {
        //获取图片对象
        Picture* picture = [_trailDetail.pictureArr objectAtIndex:indexPath.item];
        //NSLog(@"==%@",picture.picture);
        //cell
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cover forIndexPath:indexPath];
        
        
        //设置cell
        [[[cell.contentView subviews] firstObject] removeFromSuperview];
        UIImageView* imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 150)];
        PlaceholdAnimateView* place = [[PlaceholdAnimateView alloc] initWithFrame:CGRectMake(140, 55, 40, 40)];
        [imagev addSubview:place];
        [place start];
        
        [imagev sd_setImageWithURL:[NSURL URLWithString:picture.picture] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [place cancel];
        }];
        [cell.contentView addSubview:imagev];
        
        
        //容器
        UILabel* label_bg = [[UILabel alloc] initWithFrame:CGRectMake(240, 110, 80, 30)];
        label_bg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        //label_bg.backgroundColor = [UIColor redColor];
        [imagev addSubview:label_bg];
        
        //文字
        UILabel* label_count = [[UILabel alloc] initWithFrame:CGRectMake(30,5,60,20)];
        label_count.textColor = [UIColor whiteColor];
        label_count.font = [UIFont systemFontOfSize:11];
        //赋值
        NSString * str = [NSString stringWithFormat:@"%ld/%ld",indexPath.item+1,_trailDetail.pictureArr.count];
        label_count.text = str;
        [label_bg addSubview:label_count];
        
        //图片
        UIImageView* image_pic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        image_pic.image = [UIImage imageNamed:@"img_picture_21x21@2x"];
        [label_bg addSubview:image_pic];
        
        
        
        [imagev release];
        [label_bg release];
        [label_count release];
        [image_pic release];
        
        return  cell;

    }
    else if(collectionView.tag == 102)
    {
        //获取数据
        NSString * picUrlStr = [_trailDetail.traitArr objectAtIndex:indexPath.row];
        //设置cell
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //设置cell
        UIImageView* imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        [imagev sd_setImageWithURL:[NSURL URLWithString:picUrlStr]];
        [cell.contentView addSubview:imagev];
        [imagev release];
        
        
        return cell;

    }
    return nil;
    
}

//选中cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"hekkoi");
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+20);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    PictureViewController* pictureVC = [[PictureViewController alloc] initWithCollectionViewLayout:layout];
    //传值
    pictureVC.titleNB = _trailDetail.name;
    pictureVC.pictureArr = _trailDetail.pictureArr;
    pictureVC.current_index = indexPath;//把当前索引传递过去
    
    pictureVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:pictureVC animated:YES];
    //pictureVC.hidesBottomBarWhenPushed = NO;
    [pictureVC release];
}



@end
