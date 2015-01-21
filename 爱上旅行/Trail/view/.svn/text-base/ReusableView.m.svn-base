//
//  ReusableView.m
//  爱上旅行
//
//  Created by gdy on 15-1-5.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "ReusableView.h"

@implementation ReusableView

-(void)dealloc
{
    self.textLabel = nil;
    self.lineLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat height=self.bounds.size.height;
        CGFloat width=self.bounds.size.width;
        self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, width-20, height-1)];
        _textLabel.textAlignment=NSTextAlignmentLeft;
        _textLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_textLabel];
        [_textLabel release];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height-1, width-20, 1)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineLabel];
        [_lineLabel release];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
