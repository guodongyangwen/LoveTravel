//
//  PictureViewController.m
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "PictureViewController.h"

#define identifier @"collectionViewCell"

@interface PictureViewController ()
@property(nonatomic,assign)BOOL is_showNB;//是否显示NB
@property(nonatomic,assign)BOOL is_scale;//是否缩放
@property(nonatomic,retain)UITapGestureRecognizer* tap1;//轻拍两次
@property(nonatomic,retain)UITapGestureRecognizer* tap;//轻拍一次
@end

@implementation PictureViewController

-(void)dealloc
{
    //self.pictureArr = nil;
    self.current_index = nil;
    self.titleNB = nil;
    self.tap1 = nil;
    self.tap = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
       self.is_showNB = 1;//显示NB
        self.is_scale = 0;
     self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //属性
    self.collectionView.showsHorizontalScrollIndicator = NO;

    //注册cell
    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //自定义NB
    [self customizeNB];
}

//自定义NB
-(void)customizeNB
{
    //动画label  标题
    CUSFlashLabel* customLab = [[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [customLab setFont:[UIFont systemFontOfSize:17]];
    [customLab setTextColor:[UIColor colorWithRed:188 green:230 blue:80 alpha:1.0]];
    [customLab setSpotlightColor:[UIColor blackColor]];
    [customLab setContentMode:UIViewContentModeBottom];
    [customLab startAnimating];
    [customLab setText:_titleNB];
    self.navigationItem.titleView = customLab;
    
    //返回按钮
    //
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame =CGRectMake(0, 0,25 , 20);
    [leftButton addTarget:self action:@selector(leftHandle:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_actionbar_back_33x44@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}

//视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    //先把 collectionView隐藏
    [self.collectionView setHidden:YES];
}
//视图已经布局完成，要显示。  该方法在    collectionView  的   代理方法之后执行
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.collectionView setHidden:NO];
    //滚动到  collectionView  的  指定位置，改位置相对于   contentSize 来说
    [self.collectionView scrollRectToVisible:CGRectMake(_current_index.item * 320, 0, 320, 455) animated:NO];
    //选中  某个item
//    [self.collectionView selectItemAtIndexPath:_current_index animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

//NB左按钮 事件处理

-(void)leftHandle:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  collectionView代理方法
//分区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_pictureArr count];
}

//item设置
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //设置cell
    cell.picture = [_pictureArr objectAtIndex:indexPath.row];
    
    
    //重新出现的时候，把比例 恢复原来的大小
    [cell.imageView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
#pragma mark  添加手势
    //打开用户交互
    cell.imageView.userInteractionEnabled = YES;
    //轻拍手势  两次
    _is_scale = 0;
    
    self.tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle1:)];
    _tap1.numberOfTapsRequired = 2;//轻拍次数
    _tap1.numberOfTouchesRequired = 1;//手指个数
    [cell.imageView addGestureRecognizer:_tap1];
    [_tap1 release];

    //给图片添加  手势
   self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    cell.imageView.userInteractionEnabled = YES;
    [cell.imageView addGestureRecognizer:_tap];
    [_tap release];
    
    //两个手势之间创建一个  关系，延时
    //轻拍一次  手势   需要  轻拍两次手势   失败之后  执行
    [_tap requireGestureRecognizerToFail:_tap1];
    
    return cell;
}

#pragma mark 手势处理
//轻拍手势   两次
-(void)tapHandle1:(UITapGestureRecognizer*)tap
{
    
    
    if(_is_scale == NO)//进行放大
    {
        tap.view.transform = CGAffineTransformScale(tap.view.transform, 1.5, 1.5);
    }
    else//进行缩小
    {
        [tap.view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    }
    
    _is_scale = !_is_scale;
}


//轻拍手势处理
-(void)tapHandle:(UITapGestureRecognizer*)tap
{
    if(_is_showNB == 1)//消失
    {
        //NSLog(@"%@",tap.view);
        //[UIView beginAnimations:@"消失" context:self.collectionView];
        self.navigationController.navigationBarHidden = YES;
        [((PictureCollectionViewCell*)[[self.collectionView visibleCells] firstObject]).textDescription setHidden:YES];
        
        //[UIView commitAnimations];
    }
    else
    {
        //[UIView beginAnimations:@"出现" context:self.collectionView];
        
        self.navigationController.navigationBarHidden = NO;
        [((PictureCollectionViewCell*)[[self.collectionView visibleCells] firstObject]).textDescription setHidden:NO];
        //[UIView commitAnimations];
    }
    
    _is_showNB = !_is_showNB;

}




//重写   设置索引方法     选中当前索引图片
-(void)setCurrent_index:(NSIndexPath *)current_index
{
    if(_current_index != current_index)
    {
        [_current_index release];
         _current_index = [current_index retain];
        
    }
    
}




@end
