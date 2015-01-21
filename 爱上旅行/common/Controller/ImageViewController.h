//
//  ImageViewController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@class PictureViewController;
@interface ImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,retain)UICollectionView *collecView;

@property(nonatomic,retain)NSMutableArray *imageUrlArr;

@property(nonatomic,assign)CGRect frame; //图片frame
@property(nonatomic,copy)NSString* title;
@property(nonatomic,retain)UIViewController *superVC;
@property(nonatomic,retain)NSArray *pictureArr;


@end
