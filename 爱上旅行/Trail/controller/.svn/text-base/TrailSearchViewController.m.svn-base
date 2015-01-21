//
//  TrailSearchViewController.m
//  爱上旅行
//
//  Created by gdy on 15-1-5.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "TrailSearchViewController.h"

@interface TrailSearchViewController ()
@property(nonatomic,retain)NSArray* areaArr,*crowdArr,*traitArr;
@property(nonatomic,retain)UICollectionView* collectionView;
@property(nonatomic,retain)UICollectionViewFlowLayout* layout;
@end

@implementation TrailSearchViewController

-(void)dealloc
{
    self.searchTF = nil;
    self.areaArr = nil;
    self.crowdArr = nil;
    self.traitArr = nil;
    self.collectionView = nil;
    self.layout = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //初始化数据
        //地区数组
        self.areaArr = @[@"西藏",@"新疆",@"浙江",@"云南",@"四川",@"安徽",@"广东",@"内蒙古",@"北京",@"陕西",@"湖南",@"河北",@"福建",@"贵州",@"广西",@"江西"];
        //人群数组
        self.crowdArr = @[@"休闲派",@"技术流",@"重装客",@"探险家",@"享乐派",@"户二代",@"人文客",@"摄影控",@"独行侠"];
        //特点数组
        self.traitArr = @[@"雪山",@"草原",@"沙漠",@"竹海",@"丹霞",@"峡谷",@"海岛",@"喀斯特",@"古道",@"梯田",@"古村"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self customizeNB];
    [self layoutSubView];
    
    //注册cell
    [self.collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:@"cell"];
}

//布局
-(void)layoutSubView
{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.itemSize = CGSizeMake(40, 30);
    _layout.minimumInteritemSpacing = 20;
    _layout.minimumLineSpacing = 20;
    
    
    //页眉，页脚
    _layout.headerReferenceSize = CGSizeMake(320, 30);
   // _layout.footerReferenceSize = CGSizeMake(320, 30);
    
   
    
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 504) collectionViewLayout:_layout];
    //属性
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentSize = CGSizeMake(320,504+20);
    _collectionView.scrollEnabled = YES;
    //代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //添加手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [_collectionView addGestureRecognizer:tap];
    [tap release];
    
    //注册
    //注册
    [_collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //添加
    [self.view addSubview:_collectionView];
    [_collectionView release];
    
    
}


//自定义NB
-(void)customizeNB
{
    UIButton *leftBtn=[UIButton buttonWithType: UIButtonTypeSystem];
    leftBtn.frame=CGRectMake(0, 0, 20, 30);
    [leftBtn addTarget:self action:@selector(backListView) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_navigationbar_back_33x44@2x.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //textField
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(-10, 0, 200, 30)];
    _searchTF.backgroundColor = [UIColor whiteColor];
    _searchTF.placeholder = @"搜索地区 适合人群 路线特点";
    _searchTF.font = [UIFont systemFontOfSize:13];
    _searchTF.layer.cornerRadius = 6.0;
    _searchTF.keyboardType = UIKeyboardTypeWebSearch;
    _searchTF.delegate = self;//代理
    
    //左视图
    UIImageView* imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_actionbar_search_pressed_44x44@2x"]];
    imageV.frame = CGRectMake(0, 0, 35, 35);
    _searchTF.leftView = imageV;
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    [imageV release];
    
    //右视图
    UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [clearBtn addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setBackgroundImage:[UIImage imageNamed:@"textFclear.png"] forState:UIControlStateNormal];
    clearBtn.frame=CGRectMake(0, 0, 15, 15);
    _searchTF.rightView=clearBtn;
//    _searchTF.rightViewMode=UITextFieldViewModeUnlessEditing;
    _searchTF.rightViewMode = UITextFieldViewModeWhileEditing;
    
    //NB右  按钮
    UIButton *rightBtn=[UIButton buttonWithType: UIButtonTypeSystem];
    rightBtn.frame=CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.titleView=_searchTF;
    
    
}

//清除  文本框的 搜索内容
-(void)clearText:(UIButton*)btn
{
    self.searchTF.text = @"";
}

//返回
-(void)backListView
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//搜索按钮处理
-(void)searchHandle:(UIButton*)btn
{
    if ([_searchTF.text isEqualToString:@""]) {
      UIAlertView* alert =  [[UIAlertView alloc] initWithTitle:nil message:@"搜索内容为空" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:1.3];
        [alert release];
    }else{
        self.passValue(_searchTF.text);
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

//点击键盘搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchHandle:nil];
    [self.searchTF resignFirstResponder];
    return YES;
}

//手势处理
-(void)tapHandle:(UITapGestureRecognizer*)tap
{
    [self.searchTF resignFirstResponder];
}

//代理方法
//分区标题
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView* view  = nil;
    //标题
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        ReusableView* myHeader = (ReusableView*)view;
        switch (indexPath.section) {
            case 0:
                myHeader.textLabel.text = @"热门地区";
                break;
            case 1:
                myHeader.textLabel.text = @"适合人群";
                break;
                
            default:
                break;
                
        }
    
    }
    
    return view;
}

//设置size
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets inset;
    if(section == 0)
    {
        inset = UIEdgeInsetsMake(0, 10, 0, 10);
                 
    }
    else if(section == 1)
    {
        inset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return  inset;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return 25;
            break;
        case 1:
            return 30;
            break;
            
        default:
            break;
    }
    return 0;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(40, 30);
            break;
        case 1:
            return CGSizeMake(80, 30);
            break;
            
        default:
            break;
    }
    return CGSizeMake(40, 30);;
}


//区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  2;
}
//分区中  item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [_areaArr count];
            break;
        case 1:
            return [_crowdArr count];
            break;
            
        default:
            break;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            self.layout.itemSize = CGSizeMake(50, 30);
            self.layout.minimumInteritemSpacing = 12;
            
            
            NSString* title = [_areaArr objectAtIndex:indexPath.row];
            [cell.btn setTitle:title forState:UIControlStateNormal];
            [cell.btn addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn setShowsTouchWhenHighlighted:YES];
            
        }
            break;
        case 1:
        {
            self.layout.itemSize = CGSizeMake(80, 30);
            self.layout.minimumInteritemSpacing = 30;
            
           
            NSString* title = [_crowdArr objectAtIndex:indexPath.row];
            [cell.btn setTitle:title forState:UIControlStateNormal];
            [cell.btn addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


//按钮点击事件
-(void)btnHandle:(UIButton*)btn
{
    NSString* title = btn.titleLabel.text;
    self.passValue(title);
    //回收键盘
    [self.searchTF resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
