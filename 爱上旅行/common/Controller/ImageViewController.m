//
//  ImageViewController.m
//  爱上旅行
//
//  Created by 闪 on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ImageViewController.h"
#import "PictureViewController.h"
@interface ImageViewController ()

@property(nonatomic,retain)UIPageControl *pageCon;
@property(nonatomic,retain)UICollectionViewFlowLayout *layout;
@end

@implementation ImageViewController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)layoutSubView
{
    //创建collectionView
    self.layout=[[UICollectionViewFlowLayout alloc]init];
    //设置为水平移动
    _layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    _layout.itemSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    
   //创建collectionview
    self.collecView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 310, self.frame.size.height) collectionViewLayout:_layout];
    _collecView.showsHorizontalScrollIndicator=NO;
    _collecView.delegate=self;
    _collecView.dataSource=self;
    [_collecView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    _collecView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collecView];
    [_collecView release];
    
    self.pageCon=[[UIPageControl alloc]initWithFrame:CGRectMake(100, self.frame.size.height+5, 120, 30)];
    [_pageCon addTarget:self action:@selector(pageHandle:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageCon];
    
    
    [_pageCon release];
    
}


-(void)setFrame:(CGRect)frame
{
    _frame=frame;
    self.collecView.frame=CGRectMake(0, 0, 320, frame.size.height);
    self.layout.itemSize=CGSizeMake(frame.size.width, frame.size.height);
    [self layoutSubView];
}

-(void)pageHandle:(UIPageControl *)pageCon
{
    NSInteger page=pageCon.currentPage;
    [self.collecView setContentOffset:CGPointMake(page*310, 0) animated:YES];
}
-(void)setImageUrlArr:(NSMutableArray *)imageUrlArr
{
    if (_imageUrlArr!=imageUrlArr) {
        [_imageUrlArr release];
        _imageUrlArr=[imageUrlArr retain];
    }
    self.pageCon.numberOfPages=[self.imageUrlArr count]/5;
    self.pageCon.currentPage=0;
    self.pageCon.currentPageIndicatorTintColor=[UIColor colorWithRed:57/255.0 green:117/255.0 blue:202/255.0 alpha:1];
    self.pageCon.pageIndicatorTintColor=[UIColor grayColor];
    
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
     return 2.5;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imageUrlArr count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到图片展示页面
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    PictureViewController *picVC=[[PictureViewController alloc]initWithCollectionViewLayout:layout];
    picVC.pictureArr=[NSMutableArray arrayWithArray:_pictureArr];
    picVC.current_index=indexPath;
    picVC.titleNB=self.title;
    picVC.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController  pushViewController:picVC animated:YES];

}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:cell.contentView.frame];
    [imageV setBackgroundColor:[UIColor lightGrayColor]];
    NSURL *url=[_imageUrlArr objectAtIndex:indexPath.row];
    [imageV sd_setImageWithURL:url];
    [cell.contentView addSubview:imageV];
    
    self.pageCon.currentPage=indexPath.item/5;
    [imageV release];
    return cell;
}

//-(void)setPictureArr:(NSArray *)pictureArr
//{
//    self. ;
//}
//-(void)setSuperVC:(UIViewController *)superVC
//{
//    self.superVC=[superVC retain];
//}
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
