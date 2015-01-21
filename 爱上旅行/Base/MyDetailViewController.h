//
//  MyDetailViewController.h
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialSnsService.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialData.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialConfig.h"

@interface MyDetailViewController : UIViewController<UMSocialUIDelegate>
@property(nonatomic,retain)UIButton* backButton;//返回按钮


-(void)dealloc;
@end
