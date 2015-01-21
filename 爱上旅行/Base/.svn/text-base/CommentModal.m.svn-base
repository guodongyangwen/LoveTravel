//
//  CommentModal.m
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CommentModal.h"

@implementation CommentModal
-(void)dealloc
{
    self.created_date = nil;
    self.trail_score = nil;
    self.Id = nil;
    self.auther = nil;
    self.crowdArr = nil;
    [super dealloc];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if([key isEqualToString:@"id"])//评论id
    {
        self.Id = value;
    }
    if([key isEqualToString:@"created_by"])//创建人
    {
        //NSLog(@"%@",value);
        self.auther =[[Author alloc] init];
        [self.auther setValuesForKeysWithDictionary:value];
    }
    if([key isEqualToString:@"created_date"])
    {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[value floatValue]];
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy/MM/dd HH:mm"];
        self.created_date = [format stringFromDate:date];
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
    //[super setValue:value forKey:key];
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //do nothing
}





-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_comment];
}
@end
