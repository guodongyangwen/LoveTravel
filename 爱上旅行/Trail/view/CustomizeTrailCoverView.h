//
//  CustomizeTrailCoverView.h
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trail.h"
#import "UIImageView+WebCache.h"

@interface CustomizeTrailCoverView : UIView
@property(nonatomic,retain)UIImageView* imageView;//封面
@property(nonatomic,retain)UILabel* label_name;//路线名称

@property(nonatomic,retain)Trail* trail;//路线数据

-(void)dealloc;
@end
