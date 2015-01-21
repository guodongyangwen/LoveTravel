//
//  AdvertiseIcon.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "AdvertiseIcon.h"

@implementation AdvertiseIcon
-(void)dealloc{
    self.adverId = nil;
    self.title = nil;
    self.pictureUrl = nil;
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.adverId=value;
    }
    if ([key isEqualToString:@"picture"]) {
        self.pictureUrl=[value valueForKey:@"picture"];
    }
}

@end
