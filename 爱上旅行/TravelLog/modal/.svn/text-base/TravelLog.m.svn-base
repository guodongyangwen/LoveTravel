//
//  TravelLog.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TravelLog.h"

@implementation TravelLog

-(void)dealloc
{
    self.cover = nil;
    self.start_date = nil;
    self.end_data = nil;
    self.photo_number = nil;
    self.name = nil;
    self.trail_id = nil;
    self.destination = nil;
    self.total_days = nil;
    self.TravelLogId = nil;
    self.avatar = nil;
    self.nickname = nil;
    self.author = nil;
    [super dealloc];
}

-(void)setValue:(id)value forKey:(NSString *)key
{

    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        
        self.TravelLogId  = [NSString stringWithFormat:@"%@",value];
        
    }
    
    if ([key isEqualToString:@"created_by"]) {
        
        self.author=[[Author alloc]init];
        [self.author setValuesForKeysWithDictionary:value];
        [self.author release];
    }
    



}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
@end
