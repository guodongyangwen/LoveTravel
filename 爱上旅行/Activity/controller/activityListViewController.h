//
//  activityListViewController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "MyDetailViewController.h"
#import "RequestHandle.h"
#import "ActivityList.h"
#import "AcDetailVController.h"
#import "BufferingView.h"  //缓冲视图
#import "SearchTVController.h"
#import "CUSFlashLabel.h"
#import "MJRefresh.h" //上拉加载 下拉刷新

@class ActivityTableViewCell;
@interface activityListViewController : MyDetailViewController<UITableViewDataSource,UITableViewDelegate,RequestHandleDelegate>
@property(nonatomic,copy)NSString *urlId,*title;

@end
