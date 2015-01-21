//
//  logDays.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-31.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "logDays.h"
@implementation logDays


-(void)dealloc
{
    self.trail_day = nil;
    self.pictureArr = nil;
    [super dealloc];
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if([key isEqualToString:@"day"])
    {
        NSString* str = [NSString stringWithFormat:@"%@",value];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[str floatValue]];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy/MM/dd"];
        self.trail_day = [format stringFromDate:date];
        
    }
    
    if([key isEqualToString:@"pictures"])
    {
        //图片对象数组
        self.pictureArr = [[NSMutableArray alloc] init];
        for (NSDictionary* pic in value) {
            Picture* picture = [[Picture alloc] init];
            [picture setValuesForKeysWithDictionary:pic];
            [self.pictureArr addObject:picture];
        }
    }
    

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{


}



@end
