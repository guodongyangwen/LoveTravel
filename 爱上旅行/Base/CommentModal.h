//
//  CommentModal.h
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Crowds.h"

@interface CommentModal : NSObject
@property(nonatomic,copy)NSString* comment;//评论内容
@property(nonatomic,copy)NSString* created_date;//创建日期(utc时间)
@property(nonatomic,copy)NSString* trail_score;//路线评分(int->string)
@property(nonatomic,copy)NSString* Id;//（和系统重名，id->Id)
@property(nonatomic,retain)Author* auther;//创建人
@property(nonatomic,retain)NSMutableArray* crowdArr;//适合人群数组


-(void)dealloc;
-(NSString *)description;
@end
