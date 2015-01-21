//
//  Routes.m
//  爱上旅行
//
//  Created by 闪 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Routes.h"

@implementation Routes
-(void)dealloc
{
    self.start_time = nil;
    self.start_date = nil;
    self.content = nil;
    [super dealloc];
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"start_date"]) {
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[value intValue]];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        self.start_date=[format stringFromDate:date];
    }
}
@end
