//
//  Club.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Club.h"

@implementation Club

-(void)dealloc
{
    
    self.area_id = nil;
    self.city_id = nil;
    self.Id = nil;
    self.logo = nil;
    self.phone = nil;
    self.province_id = nil;
    self.title = nil;
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    [self autoDecode:aDecoder];
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        self.Id=[NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"area_id"]) {
        self.area_id=[NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"city_id"]) {
        self.city_id=[NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"province_id"]) {
        self.province_id=[NSString stringWithFormat:@"%@",value];;
    }
}

@end
