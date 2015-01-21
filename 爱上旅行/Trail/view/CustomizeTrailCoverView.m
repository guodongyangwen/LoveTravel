//
//  CustomizeTrailCoverView.m
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CustomizeTrailCoverView.h"

@implementation CustomizeTrailCoverView

-(void)dealloc
{
    self.imageView = nil;
    self.label_name = nil;
    self.trail = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //布局
        //封面
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [self.imageView setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:_imageView];
        [_imageView release];
        //名字容器
        UILabel* container = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
        container.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:container];
        [container release];
        //名称
        self.label_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        _label_name.textColor = [UIColor whiteColor];
        _label_name.font = [UIFont systemFontOfSize:15];
        [container addSubview:_label_name];
        [_label_name release];
        
    }
    return self;
}



-(void)setTrail:(Trail *)trail
{
    if(_trail != trail)
    {
        [_trail release];
        _trail = [trail retain];
        //设置封面
        [_imageView sd_setImageWithURL:[NSURL URLWithString:trail.cover]];
        //名称
        _label_name.text = trail.name;
    }
}


@end
