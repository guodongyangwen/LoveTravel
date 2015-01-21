//
//  TrailTypeTableViewController.h
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHandle.h"
#import "TrailType.h"
#import "MJRefresh.h"
#import "CustomizeTrailTypeTableViewCell.h"
#import "TrailListOfTypeTableViewController.h"


@interface TrailTypeTableViewController : UITableViewController<RequestHandleDelegate>
@property(nonatomic,retain)UINavigationController *superNavigationController;

-(void)dealloc;
@end
