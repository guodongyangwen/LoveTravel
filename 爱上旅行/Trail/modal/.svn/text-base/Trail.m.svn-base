//
//  Trail.m
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Trail.h"

@implementation Trail

-(void)dealloc
{
    self.activity_count = nil;
    self.cover = nil;
    self.name = nil;
    self.author = nil;
    self.created_date = nil;
    self.destination = nil;
    self.Id = nil;
    self.is_new = nil;
    self.is_willing = nil;
    self.logs_count = nil;
    self.willing = nil;
    self.trail_score = nil;
    self.score = nil;
    self.score_count = nil;
    [super dealloc];
}


-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"created_by"])
    {
        [_author setValuesForKeysWithDictionary:value];
    }
    if([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
    if([key isEqualToString:@"activity_count"])
    {
        self.activity_count = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"created_date"])
    {
        //把时间转换一下
        self.created_date = value;
    }
    if([key isEqualToString:@"is_willing"])
    {
        self.is_willing = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"is_new"])
    {
        self.is_new = [NSString stringWithFormat:@"%@",value];
        //NSLog(@"%@",_is_new);
    }
    if([key isEqualToString:@"logs_count"])
    {
        self.logs_count = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"willing"])
    {
        self.willing = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"trail_score"])
    {
        self.trail_score = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"score"])
    {
        self.score = [NSString stringWithFormat:@"%@",value];
    }
    if([key isEqualToString:@"score_count"])
    {
        self.score_count = [NSString stringWithFormat:@"%@",value];
    }
    
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //do nothing
}
@end
