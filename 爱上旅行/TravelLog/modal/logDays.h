//
//  logDays.h
//  爱上旅行
//
//  Created by 齐浩 on 14-12-31.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface logDays : NSObject
@property(nonatomic,copy)NSString* trail_day; //
@property(nonatomic ,retain)NSMutableArray *pictureArr; //图片数组

-(void)dealloc;
@end
