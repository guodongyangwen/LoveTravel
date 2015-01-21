//
//  Crowds.m
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Crowds.h"

@implementation Crowds

-(void)dealloc
{
    self.Id = nil;
    self.name = nil;
    self.crowd_count = nil;
    [super dealloc];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
    if([key isEqualToString:@"count"])
    {
        self.crowd_count = [NSString stringWithFormat:@"%@",value];
    }
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
