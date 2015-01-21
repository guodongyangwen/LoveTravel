//
//  Picture.h
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject
@property(nonatomic,copy)NSString* description;//图片描述
@property(nonatomic,copy)NSString* picture;//图片url
@property(nonatomic,copy)NSString* up_count;//点赞数
@property(nonatomic,copy)NSString* comment_count;//评论数

@property(nonatomic,copy)NSString *picName; //图片名称
@property(nonatomic,copy)NSString *authorName; //作者名字
@property(nonatomic,copy)NSString *authorUrl; //作者头像
@property(nonatomic,copy)NSString *height;//图片高度

//**********************************此处有一个“游记”没有处理


-(void)dealloc;
@end
