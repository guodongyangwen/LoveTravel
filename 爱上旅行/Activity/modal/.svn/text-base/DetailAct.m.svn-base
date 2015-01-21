//
//  DetailAct.m
//  爱上旅行
//
//  Created by 闪 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "DetailAct.h"
#import "ActivityList.h"
@implementation DetailAct
-(void)dealloc
{
    
    
    self.application_notes = nil;self.comment_count = nil;
    self.cost_detail = nil;self.equipment = nil;
    self.gather_place = nil;self.gather_time = nil;
    self.group_leaderName = nil;self.sign_end_time = nil;
    self.stay_place = nil;self.routeArr = nil;
    self.attraction = nil; self.pictureArr = nil;
    [super dealloc];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"group_leader"]) {
        self.group_leaderName=[value valueForKey:@"nickname"];
    }
    if ([key isEqualToString:@"sign_end_time"]) {
        NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:[value floatValue]];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy/MM/dd HH:MM"];
        self.sign_end_time=[format stringFromDate:date];
    }
   
    if ([key isEqualToString:@"pictures"]) {
        for (NSDictionary  *dic in value) {
            Picture *pict=[[Picture alloc]init];
            [pict setValuesForKeysWithDictionary:dic];
            if (self.pictureArr==nil) {
                self.pictureArr=[[NSMutableArray alloc]init];
            }
            [self.pictureArr addObject:pict];
        }
    }
    if ([key isEqualToString:@"routes"]) {
        for (NSDictionary *dic in value) {
            Routes *route=[[Routes alloc]init];
            [route setValuesForKeysWithDictionary:dic];
            if (self.routeArr==nil) {
                self.routeArr=[[NSMutableArray alloc]init];
            }
            [self.routeArr addObject:route];
            [route release];
        }
    }
}

//-(void)setActivity:(ActivityList *)activity
//{
//    if (_activity!=activity) {
//        [_activity release];
//        _activity=[activity retain];
//    }
//}

@end
