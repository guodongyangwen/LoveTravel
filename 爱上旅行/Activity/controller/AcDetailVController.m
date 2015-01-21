//
//  AcDetailVController.m
//  爱上旅行
//
//  Created by 闪 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "AcDetailVController.h"
#import "ActivityList.h"
#import "BufferingView.h"
#define labelHeight 20
#define labelEdge 5
#define labelWidth 75
#define rightLabelX 80
#define leftLabelX 10

@interface AcDetailVController ()
{
    CGFloat titleHeight;
    CGFloat clubY;
    CGFloat imageVY;
    CGFloat actIntroduceY;
    CGFloat textSize;
    
   
    
}
@property(nonatomic,retain)NSString *app_version,*device_type;//请求参数

@property(nonatomic,retain)UIScrollView *bg_scrollV;

//轮播图数组
@property(nonatomic,retain)NSArray *pictureArr;
@property(nonatomic,retain)NSMutableArray *picUrlArr;
//行程数组
@property(nonatomic,retain)NSArray *routeArr;

@property(nonatomic,retain)DetailAct *detail;
@property(nonatomic,retain)NSMutableArray *dayRouteArr; //以每天日程为单位的数组

@property(nonatomic,retain)BufferingView *buffV;

@property(nonatomic,retain)ImageViewController *collecView;
@property(nonatomic,retain)RequestHandle *request;

@property(nonatomic,copy)NSString *userId;
@end

@implementation AcDetailVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.app_version=@"1.0.2";
        self.device_type=@"1";
        textSize=14.0;
        self.data=nil;  // data初始化为空，如果是从收藏页面跳转过来的话属性传值
   }
    return self;
}

-(void)dealloc
{
    self.urlId = nil;
    self.data = nil;
    self.activity = nil;
    self.app_version=nil;
    self.device_type=nil;
    self.pictureArr=nil;
    self.picUrlArr=nil;
    self.bg_scrollV=nil;
    self.detail=nil;
    self.routeArr=nil;
    self.dayRouteArr=nil;
    self.buffV=nil;
    self.collecView=nil;
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    //self.tabBarController.tabBar.hidden=YES;
     [super viewWillAppear:animated];
    [_socialBar updateButtonNumber];
    [_socialBar requestUpdateButtonNumber];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.request cancelConnection];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //获取登录信息
    [self getUserId];
    self.buffV=[[BufferingView alloc]init];
    [self.view addSubview:_buffV];
    [_buffV start];
    

    
    
    [self requestData];
    
}

-(void)getUserId
{
    NSDictionary *dic=[UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity *qqEntity=[dic valueForKey:UMShareToQzone ];
    UMSocialAccountEntity *sinaEntity=[dic valueForKey:UMShareToSina];
    
    if (qqEntity.userName) {
        self.userId=qqEntity.usid;
    }else if(sinaEntity.userName){
        self.userId=sinaEntity.usid;
    }else{
        self.userId=nil;
    }

}

#pragma mark --设置社会化组件--
-(void)layoutSocialBar
{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    //socialData 中有此页面 的唯一操作的标识 identifier
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:self.activity.title];
    //用socialData 标识每个页面唯一的socialBar
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
    UMSocialData *socialData=[[UMSocialData alloc]initWithIdentifier:self.activity.title];
   // [UMSocialData setAppKey:@"5450da62fd98c5be2802345f"];
    //设置分享文字和图片
    socialData.shareText=@"爱上旅行，爱上自由";
    socialData.shareImage=[UIImage imageNamed:@"introduce1.jpg"];
    UMSocialUrlResource *url=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:self.activity.cover];
    socialData.urlResource=url;
    //设置评论文字和图片
    socialData.commentText=@"爱上旅行，一路相随";
    socialData.commentImage=[UIImage imageNamed:@"introduce1.jpg"];

    UMSocialButton *customButton = [[UMSocialButton alloc] initWithButtonName:@"collect" socialData:socialData controller:self];
    customButton.clickHandler = ^(){
        [self collectHandle:customButton];
        
    };
    [customButton setImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    [_socialBar.barButtons addObject:customButton];
    
    
    [_socialBar.barButtons removeObjectAtIndex:3];
    [_socialBar.barButtons removeObjectAtIndex:0];
    
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
            [UMSocialQQHandler setSupportWebView:YES];
            
            [UMSocialSnsService presentSnsController:self appKey:@"5450da62fd98c5be2802345f" shareText:@"爱上旅行，爱上自由" shareImage:[UIImage imageNamed:@"introduce1.jpg"] shareToSnsNames:@[UMShareToQzone,UMShareToSina] delegate:nil ];
        
        }
        
        
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:VC];
        navigation.modalPresentationStyle=UIModalPresentationFullScreen;
        navigation.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:navigation animated:YES completion:nil];
        
    };
    */
}
#pragma mark --设置导航栏--
-(void)layoutNavigation
{
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 10, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:self.activity.title];
    self.navigationItem.titleView = customLab;
}


#pragma mark --收藏按钮事件--
#pragma mark --收藏处理--

-(void)collectHandle:(UIButton*)btn
{
    [self getUserId];
    
    //先判断是否登录   1、登录
    if (_userId)
    {
        //判断是否已收藏
        NSString *idStr=[[FileManager sharedFileManager]querryActivityDataFromDBWithUserId:_userId ActivityId:self.activity.Id];
        if ([idStr isEqualToString:self.activity.Id])
        {
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:nil message:@"此活动已在收藏列表" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alertV show];
            [alertV release];
            [self performSelector:@selector(dismissAlertV:) withObject:alertV afterDelay:1.0];
        }
        else//进行收藏
        {
            //先创建字典
            NSMutableDictionary *activityDic=[[NSMutableDictionary alloc]init];
            [activityDic setValue:self.activity.Id forKey:@"Id"];
            [activityDic setValue:self.activity.cover forKey:@"cover"];
            [activityDic setValue:self.activity.title forKey:@"title"];
            [activityDic setValue:self.activity.start_time forKey:@"start_time"];
            [activityDic setValue:self.activity.allDays forKey:@"allDays"];
            [activityDic setValue:self.activity.club.title forKey:@"clubTitle"];
            [activityDic setValue:self.activity.end_time forKey:@"end_time"];
            [activityDic setValue:self.activity.destination forKey:@"destination"];
            [activityDic setValue:self.activity.activity_type forKey:@"activity_type"];
            [activityDic setValue:self.activity.cost forKey:@"cost"];
            [activityDic setValue:self.activity.club.logo forKey:@"activity.club.logo"];
            
            [[FileManager sharedFileManager] saveActivityDetailWithUserId:_userId ActivityId:self.activity.Id DetailData:self.data Activity:activityDic];
            
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alertV show];
            [alertV release];
            [self performSelector:@selector(dismissAlertV:) withObject:alertV afterDelay:1.0];
     
        }
    }
    else{
         //跳出登录提示ActionSheet    查询数据库
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
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            //登录完成，进行收藏
            [self collectHandle:nil];
                                      });
    }
    
     else if(buttonIndex == 1)//QQ登录
    {
        //设置代理，登录成功后  调用回调方法
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            [UMSocialControllerService defaultControllerService].socialUIDelegate=self;
            [self collectHandle:nil];
        });
        
        //设置代理
        [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
        
        
    }
    
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //[self collectHandle:nil];
}
-(void)dismissAlertV:(UIAlertView*)alertV
{
    [alertV dismissWithClickedButtonIndex:-1 animated:YES];
}


#pragma mark --请求数据--
-(void)requestData
{
    if (self.data.length==0) {
        //拼接参数
        NSString *urlStr=[kAcDetail stringByAppendingString:[NSString stringWithFormat:@"/%@?app_version=%@&device_type=%@",self.urlId,self.app_version,self.device_type]];
     self.request = [[RequestHandle alloc]initWithURLString:urlStr paramString:nil method:@"GET" delegate:self];
        
    }else{
        [self dataJsonProgress:self.data];
    }
   
    
}
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{
   
    [self dataJsonProgress:data];
}
#pragma mark --数据解析过程--
-(void)dataJsonProgress:(NSData*)data
{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.detail=[[DetailAct alloc]init];
    [_detail setValuesForKeysWithDictionary:dic];
    
    
    self.pictureArr=[[NSArray alloc]init];
    self.routeArr=[[NSArray alloc]init];
    
    self.pictureArr=_detail.pictureArr;
    
    self.routeArr=_detail.routeArr;
    if (self.picUrlArr ==nil) {
        self.picUrlArr=[[NSMutableArray alloc]init];
    }
    for (Picture *pic in self.pictureArr) {
        [self.picUrlArr addObject:pic.picture];
    }
    
    [_buffV cancel];
    
    self.data=data; //收藏使用
    
    [self layoutSubView];
    [self layoutNavigation];
    [self layoutSocialBar];
}
#pragma mark --布局子视图--
-(void)layoutSubView
{
    //底部scrollView
    UIScrollView *bg_scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64-49)];
    [self.view addSubview:bg_scroll];

    
    //title  需要自适应
    CGFloat titleHeight=[NSString getHeightWithText:self.activity.title ViewWidth:310 fontName:@"TrebuchetMS-Bold" fontSize:20];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 310, titleHeight) text:self.activity.title textSize:20];
    titleLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [bg_scroll addSubview:titleLabel];
    [titleLabel release];
    
    //俱乐部
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10+titleHeight+5, 30, 20)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.activity.club.logo]];
    [bg_scroll addSubview:imageV];
    [imageV release];
    
    UILabel *clubNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 10+titleHeight+7, 250, labelHeight)];
    clubNameLabel.text=self.activity.club.title;
    clubNameLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    [bg_scroll addSubview:clubNameLabel];
    [clubNameLabel release];
    
    
    imageVY=titleHeight+50;
    //图片
    if ([self.pictureArr count]!=0) {
        self.collecView=[[ImageViewController alloc]init];
        _collecView.title = self.activity.title;
        _collecView.superVC=self;
        _collecView.view.frame=CGRectMake(5, imageVY, 310, 120);
        _collecView.frame=CGRectMake(0, 0, 60, 75);
        _collecView.pictureArr=_pictureArr;
        _collecView.imageUrlArr=self.picUrlArr; //封装的轮播图 静态的
        _collecView.view.backgroundColor=[UIColor whiteColor];
        [bg_scroll addSubview:_collecView.view];
        actIntroduceY=imageVY+110;
    }else{
        actIntroduceY=imageVY;
    }
    
    //活动简介
    //日期
    UILabel *date=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, actIntroduceY, labelWidth,labelHeight) text:@"活动时间：" textSize:textSize];
    [bg_scroll addSubview:date];
    [date release];
    NSString *time=[self.activity.start_time stringByAppendingString:[NSString stringWithFormat:@"——%@",self.activity.end_time]];
    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX, actIntroduceY, 240, labelHeight) text:time textSize:textSize ];
    dateLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [bg_scroll addSubview:dateLabel];
    [dateLabel release];
    //地点
    UILabel *address=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, actIntroduceY+labelHeight+labelEdge, labelWidth, labelHeight) text:@"活动地点：" textSize:textSize ];
    [bg_scroll addSubview:address];
    [address release];

    UILabel *addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX, actIntroduceY+labelHeight+labelEdge, 240, labelHeight) text:self.activity.destination textSize:textSize ];
    addressLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [bg_scroll addSubview:addressLabel];
    [addressLabel release];
    
    //type
    UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, address.frame.origin.y+address.frame.size.height+labelEdge, labelWidth, labelHeight) text:@"活动类型：" textSize:textSize ];
    [bg_scroll addSubview:type];
    [type release];
    
    if (self.activity.activity_type==nil) {
        self.activity.activity_type=@"无";
    }
    UILabel *typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX, address.frame.origin.y+address.frame.size.height+labelEdge, 240, labelHeight) text:self.activity.activity_type textSize:textSize ];
    [bg_scroll addSubview:typeLabel];
    typeLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [typeLabel release];
    //截止时间
    UILabel *singTime=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, type.frame.origin.y+type.frame.size.height+labelEdge*2+5, labelWidth, labelHeight) text:@"截止时间：" textSize:textSize ];
    [bg_scroll addSubview:singTime];
    [singTime release];
    
    UILabel *singTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX, type.frame.origin.y+type.frame.size.height+labelEdge*2+5, 240, labelHeight) text:self.detail.sign_end_time textSize:textSize ];
    [bg_scroll addSubview:singTimeLabel];
    singTimeLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [singTimeLabel release];
    
    //住宿方式
    UILabel *style=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, singTime.frame.origin.y+singTime.frame.size.height+labelEdge, labelWidth, labelHeight) text:@"住宿方式：" textSize:textSize ];
    [bg_scroll addSubview:style];
    [style release];
    
    UILabel *styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX,  singTime.frame.origin.y+singTime.frame.size.height+labelEdge, 240, labelHeight) text:self.detail.stay_place textSize:textSize ];
    styleLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [bg_scroll addSubview:styleLabel];
    [styleLabel release];
    //活动费用
    UILabel *cost=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, style.frame.origin.y+style.frame.size.height+labelEdge+10, labelWidth, labelHeight) text:@"活动费用：" textSize:textSize ];
    [bg_scroll addSubview:cost];
    [cost release];
    
    NSString *costStr=[self.activity.cost stringByAppendingString:@"元/人"];
    UILabel *costLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX,  style.frame.origin.y+style.frame.size.height+labelEdge+10, 240, labelHeight) text:costStr textSize:textSize ];
    [bg_scroll addSubview:costLabel];
    costLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [costLabel release];
    
    //集合时间
    UILabel *gatherTime=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, cost.frame.origin.y+cost.frame.size.height+labelEdge, labelWidth, labelHeight) text:@"集合时间：" textSize:textSize ];
    [bg_scroll addSubview:gatherTime];
    [gatherTime release];
    
    
    UILabel *gatherTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX,  cost.frame.origin.y+cost.frame.size.height+labelEdge, 240, labelHeight) text:self.detail.gather_time textSize:textSize ];
    [bg_scroll addSubview:gatherTimeLabel];
    gatherTimeLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [gatherTimeLabel release];
    
    //集合地点
    UILabel *gatherPlace=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, gatherTime.frame.origin.y+gatherTime.frame.size.height+labelEdge, labelWidth, labelHeight-5) text:@"集合地点：" textSize:textSize ];
    [bg_scroll addSubview:gatherPlace];
    [gatherPlace release];
    
    CGFloat hei=[NSString getHeightWithText:self.detail.gather_place ViewWidth:210 fontName:@"TrebuchetMS-Bold" fontSize:textSize];
    UILabel *gatherPlaceLabel=[[UILabel alloc]initWithFrame:CGRectMake(rightLabelX,  gatherTime.frame.origin.y+gatherTime.frame.size.height+labelEdge, 210, hei) text:self.detail.gather_place textSize:textSize ];
    [bg_scroll addSubview:gatherPlaceLabel];
    gatherPlaceLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:textSize];
    [gatherPlaceLabel release];
    
    //活动亮点
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, gatherPlace.frame.origin.y+gatherPlace.frame.size.height+35, 80,30) text:@"活动亮点" textSize:20 ];
    lab.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [bg_scroll addSubview:lab];
    [lab release];

    //活动亮点
    NSMutableString *str=[NSMutableString stringWithString:self.detail.attraction];
    [str replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [self.detail.attraction length]-1)];
    
    CGFloat heightL=[NSString getHeightWithText:str ViewWidth:300 fontSize:textSize];
    UILabel *lightLabel=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, lab.frame.origin.y+labelHeight+10, 300, heightL) text:str textSize:textSize ];
    [bg_scroll addSubview:lightLabel];
    [lightLabel release];
    
    //详细行程
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(leftLabelX, lab.frame.origin.y+labelHeight+10+heightL+15, 80,30) text:@"详细行程" textSize:20 ];
    lab1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [bg_scroll addSubview:lab1];
    [lab1 release];
    //
   
    CGFloat timeY=lab.frame.origin.y+labelHeight+10+heightL+15+40;
    int day=0;
    Routes *route1 = nil;
    Routes *route2 = nil;
    
    for (int i=0;i<[self.routeArr count]-1;i++) {
        if (i>0) {
            route1=_routeArr[i-1];
            route2=_routeArr[i];
        }else{
            route1.start_date=nil;
            route1.content=nil;
            route2=_routeArr[i];
        }
       
        
        if ([route2.start_date isEqualToString:route1.start_date]==NO) { //不相等 说明是新的一天
            day++;
            UILabel *dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, timeY, 55, 20) text:[NSString stringWithFormat:@"DAY %d",day] textSize:15];
            dayLabel.textAlignment=NSTextAlignmentCenter;
            dayLabel.layer.cornerRadius=6.0;
            dayLabel.layer.masksToBounds=YES;
            dayLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"labelBg.jpg"]];
            [bg_scroll addSubview:dayLabel];
            [dayLabel release];
            
            UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, timeY+5, 100, 10) text:route2.start_date textSize:13];
            dateLabel.textColor=[UIColor colorWithRed:93/255.0 green:190/255.0 blue:255/255.0 alpha:1];;
            [bg_scroll addSubview:dateLabel];
            [dateLabel release];
            timeY+=30;
        }
        CGFloat heigh=[NSString getHeightWithText:route2.content ViewWidth:220 fontSize:13];
        dayRouteView *view=[[dayRouteView alloc]initWithFrame:CGRectMake(10, timeY, 300, heigh)];
        view.Route=route2;
       
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(43, 0, 2, heigh+20)];
        imageV.image=[UIImage imageNamed:@"line .jpg"];
        [view addSubview:imageV];
        [imageV release];
        
        timeY+=heigh+10;;
        
        [bg_scroll addSubview:view];
        [view release];
    }
    UILabel *endLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, timeY-1, 30, 10) text:@"End" textSize:13];
    [bg_scroll addSubview:endLabel];
    endLabel.textColor=[UIColor colorWithRed:93/255.0 green:190/255.0 blue:255/255.0 alpha:1];
    [endLabel release];
    
    UIImageView *endImageV=[[UIImageView alloc]initWithFrame:CGRectMake(53, timeY+10, 40, 2)];
    endImageV.image=[UIImage imageNamed:@"endline.jpg"];
    [bg_scroll addSubview:endImageV];
    [endImageV release];
    
    CGFloat y=timeY+20;
    //装备要求
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 100, 30) text:@"装备要求" textSize:20];
    [bg_scroll addSubview:label1];
    label1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [label1 release];
    y+=30;
    //
    NSMutableString *equeStr=[NSMutableString stringWithString:self.detail.equipment];
    [equeStr replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [equeStr length]-1)];
    CGFloat equepHeight=[NSString getHeightWithText:equeStr ViewWidth:300 fontSize:13];
    UILabel *equepmentL=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 300, equepHeight) text:equeStr textSize:13];
    [bg_scroll addSubview:equepmentL];
    [equepmentL release];
    y+=equepHeight+20;
    //费用详情
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 100, 30) text:@"费用详情" textSize:20];
    [bg_scroll addSubview:label2];
    label2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [label2 release];
    y+=30;
    
    NSMutableString *costString=[NSMutableString stringWithString:self.detail.cost_detail];
    [costString replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [costString length]-1)];
    CGFloat costHeight=[NSString getHeightWithText:costString ViewWidth:300 fontSize:13];
    UILabel *costL=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 300, costHeight) text:costString textSize:13];
    [bg_scroll addSubview:costL];
    [costL release];
    y+=costHeight+20;
    //报名须知
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 100, 30) text:@"报名须知" textSize:20];
    [bg_scroll addSubview:label3];
    label3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [label3 release];
    y+=30;
    
    NSMutableString *String=[NSMutableString stringWithString:self.detail.application_notes];
    [String replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [String length]-1)];
    CGFloat appliHeight=[NSString getHeightWithText:String ViewWidth:300 fontSize:13];
    UILabel *applicaitonL=[[UILabel alloc]initWithFrame:CGRectMake(10, y, 300, appliHeight) text:String textSize:13];
    [bg_scroll addSubview:applicaitonL];
    [applicaitonL release];
    y+=costHeight+20;
    
    bg_scroll.contentSize=CGSizeMake(320, y+appliHeight-80);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
