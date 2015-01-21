//
//  Picture.m
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "Picture.h"

@implementation Picture

-(void)dealloc
{
    self.description = nil;
    self.picName = nil;
    self.picture = nil;
    self.up_count = nil;
    self.comment_count = nil;
    self.authorName = nil;
    self.authorUrl = nil;
    self.height = nil;
    [super dealloc];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if([key isEqualToString:@"comment_count"])
    {
        self.comment_count = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"log"]) {
        self.picName=[value valueForKey:@"name"];
        self.authorName=[[value valueForKey:@"created_by"] valueForKey:@"nickname"];
        self.authorUrl=[[value valueForKey:@"created_by"] valueForKey:@"avatar"];
    }
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
