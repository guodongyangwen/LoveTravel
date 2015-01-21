//
//  SearchCell.m
//  爱上旅行
//
//  Created by gdy on 15-1-5.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
-(void)dealloc
{
    self.btn = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self layout];
    }
    return self;
}


//布局
-(void)layout
{
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame = CGRectMake(0, 0, 50, 30);
    [self.contentView addSubview:_btn];
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
