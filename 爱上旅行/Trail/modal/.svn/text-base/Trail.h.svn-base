//
//  Trail.h
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
//路线   modal类
@interface Trail : NSObject
@property(nonatomic,copy)NSString* activity_count;//活动数(原始数据int)
@property(nonatomic,copy)NSString* cover;//封面
@property(nonatomic,copy)NSString* name;//路线名称
@property(nonatomic,retain)Author* author;//创建人
@property(nonatomic,copy)NSString* created_date;//创建日期(utc时间)
@property(nonatomic,copy)NSString* destination;//目的地
@property(nonatomic,copy)NSString* Id;//路线id（跟系统重名，需要转换）
@property(nonatomic,copy)NSString* is_new;//是否最新（int-》string）
@property(nonatomic,copy)NSString* is_willing;//是否想去（int->string)
@property(nonatomic,copy)NSString* logs_count;//游记个数（int->string）
@property(nonatomic,copy)NSString* willing;//想去个数(int->string)
@property(nonatomic,copy)NSString* trail_score;//路线得分（星星个数）
@property(nonatomic,copy)NSString* score;
@property(nonatomic,copy)NSString* score_count;


-(void)dealloc;
@end
