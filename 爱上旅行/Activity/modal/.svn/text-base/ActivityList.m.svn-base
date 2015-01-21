
//  ActivityList.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityList.h"

@implementation ActivityList
-(void)dealloc
{
    self.activity_status = nil;
    self.activity_type = nil;
    self.city = nil;
    self.club = nil;self.cost = nil;self.cover = nil;
    self.start_time = nil;self.end_time = nil;
    self.Id = nil;self.is_hot = nil;
    self.title = nil;self.original_cost = nil;
    self.cur_page = nil;self.total = nil;
    self.destination = nil;self.allDays = nil;
    
    [super dealloc];
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];

    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //[self.club autoDecode:aDecoder];
    [self autoDecode:aDecoder];
    return self;

    
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"activity_status"]) {
        self.activity_status=[NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"activity_type"]) {
        self.activity_type=[[NSString alloc]init];
        for (NSDictionary *dic in value) {
           NSString *str = [dic valueForKey:@"title"];
            self.activity_type = [self.activity_type stringByAppendingFormat:@" %@,",str];
            
        }
    }
    
    if ([key isEqualToString:@"club"]) {
        Club *club=[[Club alloc]init];
        [club setValuesForKeysWithDictionary:value];
        self.club=club;
        [club release];
            
    }
    if ([key isEqualToString:@"cost"]) {
        self.cost=[NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"start_time"]) {
        
        NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:[value floatValue]];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy/MM/dd"];
        self.start_time=[format stringFromDate:date];
    }
    
    if ([key isEqualToString:@"end_time"]) {
        NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:[value floatValue]];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy/MM/dd"];
       self.end_time=[format stringFromDate:date];
    
        //算出结束时间几号  和开始时间 几号做差  就是总天数
        NSTimeInterval intervalStart=[[format dateFromString:self.start_time] timeIntervalSince1970];
        NSTimeInterval endToStart=[value intValue]-intervalStart;
        self.allDays=[NSString stringWithFormat:@"行程%.0lf天",endToStart/3600/24];
    
    }
    
    if ([key isEqualToString:@"id"]) {
        self.Id=[NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"is_hot"]) {
        self.is_hot=[NSString stringWithFormat:@"%@",value];
    }
    
    if ([key isEqualToString:@"original_cost"]) {
        self.original_cost=[NSString stringWithFormat:@"%@",value];
    }
    
    
    
   
    
}


-(void)setClub:(Club *)club
{
    if (_club!=club) {
        [_club release];
        _club=[club retain];
    }
}
@end
