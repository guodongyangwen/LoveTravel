//
//  AcDetailVController.h
//  爱上旅行
//
//  Created by 闪 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailViewController.h"
#import "DetailAct.h"
#import "RequestHandle.h"
#import "NSString+heightHandle.h"
#import "UIImageView+WebCache.h"
#import "ImageViewController.h"
#import "UILabel+custom.h"
#import "dayRouteView.h"

#import "PictureViewController.h"
#import "FileManager.h"
#import "UMSocialBar.h"
#import "CUSFlashLabel.h"
#import "UMSocialAccountManager.h"
#import "UMSocialDataService.h"

@class  BufferingView;
@class ActivityList;
@interface AcDetailVController :  MyDetailViewController<RequestHandleDelegate,UMSocialUIDelegate,UIActionSheetDelegate>
{
    UMSocialData *_socialData;
    UMSocialBar *_socialBar;
}
@property(nonatomic,copy)NSString *urlId;
@property(nonatomic,retain)ActivityList *activity;

@property(nonatomic,retain)NSData *data;
//@property(nonatomic,retain)NSDictionary *activityDic;

@end
