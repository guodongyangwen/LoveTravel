//
//  UserTableViewController.h
//  爱上旅行
//
//  Created by gdy on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUSFlashLabel.h"
#import "UserSetTableViewController.h"
#import "UserTableViewController.h"
#import "UserImageAndLabelCell.h"


#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"
#import "UMSocialAccountManager.h"
#import "UMSocialConfig.h"
#import "UMSocialControllerService.h"
#import "UMSocialDataService.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialControllerServiceComment.h"

#import "FileManager.h"
#import "CollectTVController.h"


#import "MyTrailTableViewController.h"
#import "MyTrailLogTableViewController.h"

@interface UserTableViewController : UITableViewController<UMSocialUIDelegate>
-(void)dealloc;
@end
