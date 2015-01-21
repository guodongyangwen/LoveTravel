//
//  TrailDetail.h
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Crowds.h"
#import "Picture.h"

@interface TrailDetail : NSObject
@property(nonatomic,copy)NSString* activity_count;//活动个数
@property(nonatomic,copy)NSString* cover;//封面
@property(nonatomic,retain)Author* author;//作者
@property(nonatomic,copy)NSString* created_date;//创建日期
@property(nonatomic,retain)NSMutableArray* crowdArr;//适合人群
@property(nonatomic,copy)NSString* destination;//目的地
@property(nonatomic,copy)NSString* detail;//路线详情
@property(nonatomic,copy)NSString* Id;//路线id（与系统关键字重名，处理一下）
@property(nonatomic,copy)NSString* name;//路线名称
@property(nonatomic,retain)NSMutableArray* pictureArr;//图片数组
@property(nonatomic,copy)NSString* trail_score;//路线 得分（星星个数）(int->string)
@property(nonatomic,retain)NSMutableArray* traitArr;//特征数组


-(void)dealloc;
@end
