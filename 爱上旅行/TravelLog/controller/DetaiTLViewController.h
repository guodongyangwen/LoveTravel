//
//  DetaiTLViewController.h
//  爱上旅行
//
//  Created by 齐浩 on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetaiTLViewCell.h"
#import "HandViewCell.h"
#import "PictureViewController.h"

#import "DetailTL.h"
#import "TravelLog.h"
#import "logDays.h"
#import "UMSocialBar.h"
#import "CUSFlashLabel.h"
#import "CUSFlashLabel.h"
#import "DataBaseManager.h"
#import "FileManager.h"
//友盟
#import "UMSocialBar.h"
#import "UMSocialAccountManager.h"
#import "UMSocialDataService.h"

@interface DetaiTLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate,UMSocialDataDelegate>

{
    UMSocialData *_socialData;
    UMSocialBar *_socialBar;
}
@property(nonatomic,retain)DetailTL *detailTL;
@property(nonatomic,retain)TravelLog *travelLog;
@property(nonatomic,retain)Picture *pictures;
@property(nonatomic,retain)logDays *logDays;

@property(nonatomic,retain)NSData* detailData;

//解析的数据
@property(nonatomic,retain)NSData* dataLogs;
@property(nonatomic,assign)BOOL isAnalysis;

-(void)dealloc;
@end
