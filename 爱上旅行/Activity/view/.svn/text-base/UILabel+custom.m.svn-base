//
//  UILabel+custom.m
//  爱上旅行
//
//  Created by 闪 on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "UILabel+custom.h"

@implementation UILabel (custom)
-(id)initWithFrame:(CGRect)frame text:(NSString *)text textSize:(CGFloat)size
{
    self=[super init];
    if (self!=nil) {
        self.frame=frame;
        self.font=[UIFont fontWithName:nil size:size];
        self.textColor=[UIColor blackColor];
        self.numberOfLines=0;
        self.text=text;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=0;
        self.layer.masksToBounds=YES;
    }
    return self;
}
@end
