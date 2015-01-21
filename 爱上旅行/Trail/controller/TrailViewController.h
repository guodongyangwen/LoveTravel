//
//  TrailViewController.h
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrailTableViewCell.h"
#import "RequestHandle.h"
#import "Trail.h"
#import "UIImageView+WebCache.h"
#import "TrailDetailViewController.h"
#import "BufferingView.h"
#import "TrailTypeTableViewController.h"
#import "PlaceholdAnimateView.h"
#import "SDImageCache.h"

#import "TrailSearchViewController.h"

@interface TrailViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,RequestHandleDelegate>
@property(nonatomic,retain)UISegmentedControl* segTitle;//NB标题视图
@property(nonatomic,retain)UIScrollView* scrollView;//滚动视图
@property(nonatomic,retain)UITableView* trailLib,*trailType;//路线库和路线专题

@property(nonatomic,retain)NSArray* areaArr,*crowdArr;


-(void)dealloc;
@end
