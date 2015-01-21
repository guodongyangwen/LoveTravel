//
//  AdverTVCell.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "AdverTVCell.h"
#import "ActivityList.h"
@implementation AdverTVCell
-(void)dealloc
{
    self.action_statuLabel = nil;
    self.activity = nil;
    [super dealloc];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.action_statuLabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 220, 100, 30)];
        _action_statuLabel.layer.cornerRadius=4.0;
        _action_statuLabel.textColor=[UIColor whiteColor];
        _action_statuLabel.layer.masksToBounds=YES;
        _action_statuLabel.textAlignment=NSTextAlignmentCenter;
        _action_statuLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        _action_statuLabel.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:_action_statuLabel];
    }
    return self;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.action_statuLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 210, 60, 40)];
        _action_statuLabel.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:_action_statuLabel];
    }
    return self;

}

-(void)setActivity:(ActivityList *)activity
{
    [super setActivity:activity];
    if ([activity.activity_status isEqualToString:@"0"]) {
        self.action_statuLabel.backgroundColor=[UIColor redColor];
        self.action_statuLabel.text=@"立即参加";
    }else if ([activity.activity_status isEqualToString:@"1"]){
        self.action_statuLabel.backgroundColor=[UIColor grayColor];
        self.action_statuLabel.text=@"报名截止";
    }else{
        self.action_statuLabel.backgroundColor=[UIColor grayColor];
        self.action_statuLabel.text=@"已结束";
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
