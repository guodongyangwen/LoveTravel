//
//  ActivityList.h
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Club.h"
#import "NSObject+NSCoding.h"
@interface ActivityList : NSObject<NSCoding>
@property(nonatomic,copy)NSString *activity_status; //活动状态
@property(nonatomic,copy)NSString *activity_type; //活动类型
@property(nonatomic,copy)NSString *city; //城市
@property(nonatomic,retain)Club *club;  //俱乐部对象
@property(nonatomic,copy)NSString *cost; //花费

@property(nonatomic,copy)NSString *cover; //封面url
@property(nonatomic,copy)NSString *start_time; //出发时间
@property(nonatomic,copy)NSString *end_time; //结束日期
@property(nonatomic,copy)NSString *Id; //活动id
@property(nonatomic,copy)NSString *is_hot; //热度
@property(nonatomic,copy)NSString *title;//title
@property(nonatomic,copy)NSString *original_cost;//原价
@property(nonatomic,copy)NSString *cur_page; //当前页
@property(nonatomic,copy)NSString *total; //总页数
@property(nonatomic,copy)NSString *destination; //目的地
@property(nonatomic,copy)NSString *allDays;  //总行程天数
@property(nonatomic,assign)int start;
@property(nonatomic,assign)int end; //记录开始和结束时间的时间戳value
-(void)dealloc;
@end
