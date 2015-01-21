//
//  DetailTL.h
//  爱上旅行
//
//  Created by 齐浩 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "DetailTL.h"
#import "logDays.h"
#import "TravelLog.h"
@interface DetailTL : NSObject
@property(nonatomic,copy)NSString *source; //来源
@property(nonatomic,retain)TravelLog* trailLog;//游记日志

-(void)dealloc;
@end
