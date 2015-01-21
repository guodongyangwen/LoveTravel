//
//  UserImageAndLabelCell.h
//  爱上旅行
//
//  Created by gdy on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"
#import "UMSocialAccountManager.h"
#import "UMSocialConfig.h"
#import "UMSocialControllerService.h"
#import "UMSocialDataService.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"


@interface UserImageAndLabelCell : UITableViewCell<UMSocialUIDelegate>
@property(nonatomic,retain)UIImageView* userAvatar;//用户头像
@property(nonatomic,retain)UILabel* labelName;//用户名
@property(nonatomic,retain)UIButton* btnQQ;//QQ按钮
@property(nonatomic,retain)UIButton* btnSina;//新浪按钮


-(void)dealloc;
@end
