//
//  PictureCollectionViewCell.h
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
#import "UIImageView+WebCache.h"
#import "NSString+HeightHandle.h"
#import "PlaceholdAnimateView.h"

@interface PictureCollectionViewCell : UICollectionViewCell<UIAlertViewDelegate>
@property(nonatomic,retain)Picture* picture;//图像modal
@property(nonatomic,retain)UIImageView* imageView;//图片视图
@property(nonatomic,retain)UITextView* textDescription;//图片描述

//-(void)dealloc;
@end
