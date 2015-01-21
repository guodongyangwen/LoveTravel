//
//  TrailDetail.m
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TrailDetail.h"

@implementation TrailDetail

-(void)dealloc
{
    self.activity_count = nil;
    self.cover = nil;
    self.author = nil;
    self.created_date = nil;
    self.crowdArr = nil;
    self.destination = nil;
    self.detail = nil;
    self.Id = nil;
    self.name = nil;
    self.pictureArr = nil;
    self.trail_score = nil;
    self.traitArr = nil;
    [super dealloc];
}

//KVC
-(void)setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"trail_score"])
    {
        self.trail_score = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"created_by"])//创建人
    {
        [self.author setValuesForKeysWithDictionary:value];
    }
    if([key isEqualToString:@"crowds"])//适合人群
    {
        self.crowdArr = [[NSMutableArray alloc] init];
        for (NSDictionary* crowd in value) {
            //遍历进行封装
            Crowds* cr = [[Crowds alloc] init];
            [cr setValuesForKeysWithDictionary:crowd];
            [self.crowdArr addObject:cr];
        }
    }
    if([key isEqualToString:@"pictures"])//一组图片
    {
        //图片对象数组
        self.pictureArr = [[NSMutableArray alloc] init];
        for (NSDictionary* pic in value) {
            Picture* picture = [[Picture alloc] init];
            [picture setValuesForKeysWithDictionary:pic];
            [self.pictureArr addObject:picture];
        }
    }
    if([key isEqualToString:@"traits"])//特征数组
    {
        //只需要图片
        self.traitArr = [[NSMutableArray alloc] init];
        for (NSDictionary* trait in value) {
           NSString* urlStr = [trait objectForKey:@"url"];
            [self.traitArr addObject:urlStr];
        }
    }
    //调用父类的方法
    [super setValue:value forKey:key];
    
    
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //do nothing
}
@end
