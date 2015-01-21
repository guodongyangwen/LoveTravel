//
//  UserGuideViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-3.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "UserGuideViewController.h"

@interface UserGuideViewController ()
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@end

@implementation UserGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
    [self addImageViewOnScrollView];
    [self layOUtPageControl];
}


#pragma mark --布局子视图--


-(void)addImageViewOnScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGRect frame=[[UIScreen mainScreen]bounds];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4, frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.delegate = self;
    _scrollView.bounces=NO;
    _scrollView.pagingEnabled=YES;
    [self.view addSubview:_scrollView ];
    
    for(int i=0;i<4;i++)
    {
        CGRect frame=[[UIScreen mainScreen] bounds];
        UIImage* image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"introduce%d.jpg",i+1] ofType:nil]];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [image release];
        
        imageView.frame = CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
        [_scrollView addSubview:imageView];
        [imageView release];
        //添加手势视图
        if(i==3)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame=CGRectMake(200,frame.size.height/4*3, 100, 40);
            [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont fontWithName:@"AmericanTypewriter" size:24];
            btn.titleLabel.textColor=[UIColor colorWithRed:245/255.0 green:74/255.0 blue:56/255.0 alpha:1];
            [btn addTarget:self action:@selector(tapHandle:) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled=YES;
            [imageView addSubview:btn];
        }
        
    }
    
}

-(void)layOUtPageControl
{
    //******************************************创建PageControl
    //self.view.backgroundColor = [UIColor purpleColor];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height-60, 220, 60)];
    //页数
    self.pageControl.numberOfPages = 4;
    //设置默认 页
    self.pageControl.currentPage = 0;
    //设置当前点得颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor  = [UIColor lightGrayColor];
    //***************添加方法
    [self.pageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    
    
    //添加
    [self.view addSubview:_pageControl];
    [_pageControl release ];
}

//pageControl
-(void)pageControl:(UIPageControl*)pageControl
{
    NSInteger page_cur = pageControl.currentPage;
    _scrollView.contentOffset = CGPointMake(320*page_cur, 0);
}

//重写介乎拖拽函数
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point =  scrollView.contentOffset;
    NSInteger cur_page = point.x/320;
    _pageControl.currentPage = cur_page;
    
}
-(void)tapHandle:(UIButton*)btn
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    TabBarViewController *activityVC=[[TabBarViewController alloc]init];
        [self.navigationController pushViewController:activityVC animated:YES];
        [activityVC release];
  
    
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
