//
//  BufferingView.m
//  DouBanProject
//
//  Created by 闪 on 14-12-8.
//  Copyright (c) 2014年 北京蓝鸥科技有限公司. All rights reserved.
//

#import "BufferingView.h"

@implementation BufferingView

-(void)dealloc
{
    self.imageV = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubView];
        
    }
    return self;
}

-(void)layoutSubView
{
    
    self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(110, 180, 100, 100 )];
    NSMutableArray *imageArr=[[NSMutableArray alloc]init];
    for (int i=1; i<13; i++) {
        UIImage *image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"img%d.png",i] ofType:nil]];
        [imageArr addObject:image];
    }
    self.imageV.animationImages=imageArr;
    self.imageV.animationDuration=2.0;
    [self addSubview:_imageV];
    [_imageV release];
    
}
-(void)start
{
    [self.imageV startAnimating];
    
}
-(void)cancel
{
    [self.imageV removeFromSuperview];
}

-(void)setFrame:(CGRect)frame
{
    self.imageV.frame = frame;
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
