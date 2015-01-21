//
//  ActivityViewController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "RequestHandle.h"
#import "ActivityIcon.h"
#import "AdvertiseIcon.h"

#import "UIImageView+WebCache.h"  //图片下载
#import "AdverListVController.h" //广告列表
#import "activityListViewController.h"

#import "PlaceholdAnimateView.h"
#import "BufferingView.h"

@interface ActivityViewController : UIViewController<RequestHandleDelegate>
@property(nonatomic,retain)BufferingView* buffView;
@end
