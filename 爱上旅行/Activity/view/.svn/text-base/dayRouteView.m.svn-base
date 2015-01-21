//
//  dayRouteView.m
//  爱上旅行
//
//  Created by 闪 on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "dayRouteView.h"
#import "Routes.h"
@implementation dayRouteView

-(void)dealloc
{
    self.Route = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
     }
    return self;

}


-(void)setRoute:(Routes *)Route
{
    if (_Route!=Route) {
        [_Route release];
        _Route=[Route retain];
        
        
        //
            UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
            timeLabel.font=[UIFont fontWithName:nil size:13];
        timeLabel.text=Route.start_time;
        
            [self addSubview:timeLabel];
            [timeLabel release];
        
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 12, 2)];
        imageV.image=[UIImage imageNamed:@"route.jpg"];
        [self addSubview:imageV];
        
        NSMutableString *str=[NSMutableString stringWithString:Route.content];
        [str replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [str length]-1)];
            CGFloat height=[NSString getHeightWithText:Route.content ViewWidth:220 fontSize:13];
            UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 4, 220, height) text:Route.content textSize:13];
    
            contentLabel.numberOfLines=0;
            [self addSubview:contentLabel];
            [contentLabel release];
    

    }
    
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
