//
//  Author.m
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Author.h"

@implementation Author

-(void)dealloc
{
    
    self.avatar = nil;
    self.gender = nil;
    self.birthday = nil;
    self.Id = nil;
    self.location = nil;
    [super dealloc];
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //do nothing
}
@end
