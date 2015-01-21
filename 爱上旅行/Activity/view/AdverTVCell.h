//
//  AdverTVCell.h
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityTableViewCell.h"
@class AdvertiseList;
@interface AdverTVCell : ActivityTableViewCell
@property(nonatomic,retain)UILabel *action_statuLabel;
@property(nonatomic,retain)ActivityList *activity;
-(void)dealloc;
@end
