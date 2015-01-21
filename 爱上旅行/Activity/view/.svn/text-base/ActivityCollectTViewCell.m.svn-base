//
//  ActivityCollectTViewCell.m
//  爱上旅行
//
//  Created by 闪 on 14-12-31.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityCollectTViewCell.h"
#import "ActivityList.h"

@interface ActivityCollectTViewCell ()
@property(nonatomic,retain)UIImageView *clubImageV;
@property(nonatomic,retain)UILabel *titleLabel,*startDateLabel,*dayLabel,*clubTitleLabel;
@end
@implementation ActivityCollectTViewCell
-(void)dealloc
{
    self.activity = nil;
    self.clubImageV = nil;
    self.titleLabel = nil;
    self.startDateLabel = nil;
    self.dayLabel = nil;
    self.clubTitleLabel = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clubImageV =[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 80, 80)];
        [self.contentView addSubview:_clubImageV];
        [_clubImageV release];
        
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 15, 230, 20)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.font=[UIFont fontWithName:nil size:15];
        [_titleLabel release];
        
        self.startDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 120, 30)];
        [self.contentView addSubview:_startDateLabel];
        _startDateLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        [_startDateLabel release];
        
        self.dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(190, 46, 100, 20)];
        [self.contentView addSubview:_dayLabel];
        _dayLabel.font=[UIFont fontWithName:nil size:15];
        [_dayLabel release];
        
        self.clubTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 70, 120, 20)];
        [self.contentView addSubview:_clubTitleLabel];
        _clubTitleLabel.font=[UIFont fontWithName:nil size:15];
        [_clubTitleLabel release];
                             
    }
    return self;
}
-(void)setActivity:(ActivityList *)activity
{
    if (_activity!=activity) {
        [_activity release];
        _activity=[activity retain];
        NSURL *url=[NSURL URLWithString:activity.cover];
        [self.clubImageV sd_setImageWithURL:url];
        self.titleLabel.text=activity.title;
        self.startDateLabel.text=activity.start_time;
        self.dayLabel.text=activity.allDays;
        self.clubTitleLabel.text=activity.club.title;
    }

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
