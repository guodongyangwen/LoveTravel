//
//  ActivityViewController.m
//  爱上旅行
//
//  Created by 闪 on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityViewController.h"

#define  gap 5
#define  top  10
#define widt 100
#define heigh 75
#define topH   182

@interface ActivityViewController ()
@property(nonatomic,retain)CycleScrollView *cycleView;
@property(nonatomic,retain)NSMutableArray *imageUrlArr,*imageArr;  //轮播图url
@property(nonatomic,retain)NSMutableArray *imageViewArr; //imageView

@property(nonatomic,retain)NSMutableArray *iconUrlArr; //活动图url

@property(nonatomic,retain)RequestHandle *requestHandle1;
@property(nonatomic,retain)RequestHandle *requestHandle2;
//活动图Modal
@property(nonatomic,retain)NSMutableArray *categoryImageArr;
@property(nonatomic,retain)NSArray *titleArr;

@property(nonatomic,retain)UIImageView *imageV;

@end

@implementation ActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeThemeHandle:) name:kThemeChangeNotification object:nil];
        
    }
    return self;
}

-(void)changeThemeHandle:(NSNotification*)notification
{
    NSDictionary *dic=notification.userInfo;
    [self loadImageForImageV:dic];
}

-(void)loadImageForImageV:(NSDictionary*)dic
{
    //navigationBar 的图片名字
    NSString *name=[dic valueForKey:@"naImage"];
    NSString *subStr=[name substringWithRange:NSMakeRange(5, 1)];
    NSString *imageName=[NSString stringWithFormat:@"statebar%@.jpg",subStr];
    self.imageV.image=[UIImage imageNamed:imageName];

    if (dic==nil) {
        self.imageV.image=[UIImage imageNamed:@"statebar0.jpg"];
    }

    
}
-(void)dealloc
{
    self.cycleView=nil;
    self.imageArr=nil;
    self.imageUrlArr=nil;
    self.imageViewArr=nil;
    self.iconUrlArr=nil;
    self.requestHandle1=nil;
    self.requestHandle2=nil;
    self.categoryImageArr=nil;
    self.titleArr=nil;
    self.buffView = nil;
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationBar
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self layoutImageBtn];
    [self addActivityIndicator];
    [self requestData];

}

-(void)requestData
{
   
    NSString *str=[kAdvertisement stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.requestHandle2 = [[RequestHandle alloc]initWithURLString:str paramString:nil method:@"GET" delegate:self];

}


#pragma mark --数据请求代理方法--
-(void)requestHandle:(RequestHandle *)requestHandle requestSucceedWithData:(NSData *)data
{

    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        NSArray *arr=[dic valueForKey:@"advertisements"];
       
        for (NSDictionary *dic in arr) {
            AdvertiseIcon *adver=[[AdvertiseIcon alloc]init];
            [adver setValuesForKeysWithDictionary:dic];
            if (self.imageUrlArr ==nil) {
                self.imageUrlArr=[[NSMutableArray alloc]init];
            }
            if (self.imageArr ==nil) {
                self.imageArr=[[NSMutableArray alloc]init];
            }
            [_imageUrlArr addObject:adver];
            NSURL *url=[NSURL URLWithString:adver.pictureUrl];
            NSLog(@"url:%@",url);
            [_imageArr addObject:url];
        }
       
        [self layoutScrollView];
    [self.buffView cancel];
}
#pragma mark --布局上方滚动视图--
-(void)layoutScrollView
{
    //状态栏
    CGRect frame=[[UIScreen mainScreen]bounds];
    self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 22)];
    [self loadImageForImageV:[[NSUserDefaults standardUserDefaults]valueForKey:@"theme"]];
    
    [self.view addSubview:_imageV];
    [_imageV release];
    
    
    
    
    
    if (self.imageViewArr==nil) {
        self.imageViewArr=[[NSMutableArray alloc]init];
    }
    
    if([_imageArr count] == 1)//1个
    {
        //创建子uiimageView
        for (int i=0; i<3; i++)
        {
            
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 22, frame.size.width, 160/568.0*frame.size.height)];
            //第三方类下载图片
            [imageV sd_setImageWithURL:[_imageArr objectAtIndex:i/3] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageV.image=image;
                //            [view cancel];
            }];
            [_imageViewArr addObject:imageV];
            
            [imageV release];
        }
        
        //轮播图片
        self.cycleView=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 22, 320, 160/568.0*frame.size.height) animationDuration:2.0f];
        _cycleView.backgroundColor=[UIColor grayColor];
        //设置资源
        self.cycleView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return self.imageViewArr[pageIndex];
        };
        
        self.cycleView.totalPagesCount = ^NSInteger(void){
            return 3;
        };
        
        self.cycleView.TapActionBlock = ^(NSInteger pageIndex){
            //点击图片进入列表
            [self enterListView:pageIndex/3];
        };
        
        [self.view addSubview:_cycleView];
        [_cycleView release];
        
    }
    else if([_imageArr count] == 2)//2个
    {
        //创建子uiimageView
        for (int i=0; i<[_imageArr count]; i++)
        {
            
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 22, frame.size.width, 160/568.0*frame.size.height)];
            //第三方类下载图片
            [imageV sd_setImageWithURL:[_imageArr objectAtIndex:i%2] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageV.image=image;
                //            [view cancel];
            }];
            [_imageViewArr addObject:imageV];
            
            [imageV release];
        }
        
        //轮播图片
        self.cycleView=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 22, 320, 160/568.0*frame.size.height) animationDuration:2.0f];
        _cycleView.backgroundColor=[UIColor grayColor];
        //设置资源
        self.cycleView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return self.imageViewArr[pageIndex%2];
        };
        
        self.cycleView.totalPagesCount = ^NSInteger(void){
            return 4;
        };
        
        self.cycleView.TapActionBlock = ^(NSInteger pageIndex){
            //点击图片进入列表
            [self enterListView:pageIndex%2];
        };
        
        [self.view addSubview:_cycleView];
        [_cycleView release];

    }
    else//大于等于3个
    {
        //创建子uiimageView
        for (int i=0; i<[_imageArr count]; i++)
        {
            
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 22, frame.size.width, 160/568.0*frame.size.height)];
            //        PlaceholdAnimateView *view=[[PlaceholdAnimateView alloc]initWithFrame:CGRectMake(140/320.0*frame.size.width, 60/568.0*frame.size.height, 40/320.0*frame.size.height, 40/568.0*frame.size.height)];
            //        [_cycleView addSubview:view];
            //        [view start];
            //        [imageV addSubview:view];
            
            //[self.cycleView addSubview:imageV];
            //第三方类下载图片
            [imageV sd_setImageWithURL:[_imageArr objectAtIndex:i] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageV.image=image;
                //            [view cancel];
            }];
            [_imageViewArr addObject:imageV];
            
            [imageV release];
        }
        
        //轮播图片
        self.cycleView=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 22, 320, 160/568.0*frame.size.height) animationDuration:2.0f];
        _cycleView.backgroundColor=[UIColor grayColor];
        //设置资源
        self.cycleView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return self.imageViewArr[pageIndex];
        };
        
        self.cycleView.totalPagesCount = ^NSInteger(void){
            return [_imageArr count];
        };
        
        self.cycleView.TapActionBlock = ^(NSInteger pageIndex){
            //点击图片进入列表
            [self enterListView:pageIndex];
        };
        
        [self.view addSubview:_cycleView];
        [_cycleView release];
    }
    
    
    
}

#pragma mark --点击图片进入列表--
-(void)enterListView:(NSInteger)index
{
    
    if (index==2){
        index=0;
    }
    AdvertiseIcon *adver=_imageUrlArr[index];
    AdverListVController *adverListVC=[[AdverListVController alloc]init];
    
    adverListVC.urlId=adver.adverId;
    adverListVC.title=adver.title;
    adverListVC.url=[NSURL URLWithString:adver.pictureUrl];
    
    [self.navigationController pushViewController:adverListVC animated:YES];
    
    [adverListVC release];
    
}
#pragma mark --下方分类视图
-(void)layoutImageBtn
{
    self.titleArr=@[@"周末活动",@"长线活动",@"攀岩探洞",@"入门级",@"全部活动",@"摄影",@"进阶级",@"重装",@"培训/公益",@"强驴级",@"探险",@"高寒地带"];
    self.categoryImageArr=[[NSMutableArray alloc]init];
    
    //创建活动分类图
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            CGRect frame=[[UIScreen mainScreen]bounds];
            [_categoryImageArr addObject:[NSString stringWithFormat:@"%d",3+i*3+j]];
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(5/320.0*frame.size.width+j*(5/320.0*frame.size.width+100/320.0*frame.size.width), 10/568.0*frame.size.height+i*(75/568.0*frame.size.height+5/320.0*frame.size.width)+182/568.0*frame.size.height, 100/320.0*frame.size.width, 75/568.0*frame.size.height)];
            imageV.layer.cornerRadius=6;
            imageV.layer.masksToBounds=YES;
            imageV.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"activity%d",3*i+j] ofType:nil]];
            //图片
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activityTap:)];
            
            imageV.backgroundColor=[UIColor blackColor];
            
            
            [imageV addGestureRecognizer:tap];
            //设置imageV的tag值  点击事件中用
            imageV.tag=100+i*3+j;
            
            imageV.userInteractionEnabled=YES;
            
            [self.view addSubview:imageV];
            [imageV release];
            
        }

    }
}

#pragma mark --活动分类按钮点击--
-(void)activityTap:(UITapGestureRecognizer*)tap
{
    UIImageView *imageV=(UIImageView*)tap.view;
    NSInteger index=imageV.tag-100;
    
    //跳转到列表页面
    activityListViewController  *activityVC=[[activityListViewController alloc]init];
    activityVC.urlId=[_categoryImageArr objectAtIndex:index];
    activityVC.title=[_titleArr objectAtIndex:index];
    
    [self.navigationController pushViewController:activityVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加加载控件
-(void)addActivityIndicator
{
    
    self.buffView  = [[BufferingView alloc] init];
    [self.buffView setFrame:CGRectMake(140, 60, 40, 40)];
    [self.view addSubview:_buffView];
    [_buffView start];
    
    
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
