//
//  PlaceholdAnimateView.m
//  爱上旅行
//
//  Created by 闪 on 14-12-30.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "PlaceholdAnimateView.h"


@interface PlaceholdAnimateView ()
@property(nonatomic,retain)UIImageView *imageV;
@property(nonatomic,retain)NSMutableArray *imageArr;
@end
@implementation PlaceholdAnimateView
-(void)dealloc
{
    self.imageV = nil;
    self.imageArr = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageArr=[[NSMutableArray alloc]init];
        for (int i=1; i<7; i++) {
            UIImage *image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"progress%d.tiff",i ] ofType:nil]];
            [_imageArr addObject:image];
            
                            
        }
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageV.animationImages=self.imageArr;
        _imageV.animationDuration=2.0;
        [self addSubview:_imageV];
        [_imageV release];
    }
    return self;
}


-(void)start
{
    [self.imageV startAnimating];
    
}
-(void)cancel
{
    [self.imageV removeFromSuperview];
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
