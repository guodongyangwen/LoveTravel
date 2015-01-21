//
//  AdverListVController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "MyDetailViewController.h"
#import "ActivityTableViewCell.h"
#import "AdverTVCell.h"
#import "RequestHandle.h"
#import "CUSFlashLabel.h"

#import "ActivityList.h"
#import "UIImageView+WebCache.h"  //图片下载

#import "AcDetailVController.h"
@class BufferingView;
@interface AdverListVController : MyDetailViewController<UITableViewDataSource,UITableViewDelegate,RequestHandleDelegate>

@property(nonatomic,retain)NSURL *url;
@property(nonatomic,copy)NSString *urlId;

@property(nonatomic,retain)UITableView *cityTableV;
@property(nonatomic,retain)UIImageView *accessoryView;
@property(nonatomic,retain)NSArray *cityArr;

@end
