//
//  ActivityIcon.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityIcon.h"

@implementation ActivityIcon

-(void)dealloc
{
    self.activityId = nil;
    self.title = nil;
    self.url = nil;
    [super dealloc];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        self.activityId=[NSString stringWithFormat:@"%@",value];
    }
    
}
@end
