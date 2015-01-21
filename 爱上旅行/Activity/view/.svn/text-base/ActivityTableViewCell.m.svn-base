//
//  ActivityTableViewCell.m
//  爱上旅行
//
//  Created by 闪 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ActivityTableViewCell.h"

#import "ActivityList.h"
@implementation ActivityTableViewCell
-(void)dealloc
{
    self.is_hot = nil;
    self.bg_image = nil;
    self.clubImage = nil;
    self.dateLabel = nil;
    self.costLabel = nil;
    self.clubLabel = nil;
    self.titleLabel = nil;
    self.typeLabel = nil;
    self.destinationLabel = nil;
    self.cityLabel = nil;
    self.dayLabel = nil;
    self.activity = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //热度
        self.is_hot=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        
        //封面图
        self.bg_image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 320, 180)];
        
        _bg_image.backgroundColor=[UIColor grayColor];
        [_bg_image addSubview:_is_hot];
        
        //label
        self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 20, 100, 30)];
        _dateLabel.font=[UIFont fontWithName:nil size:14];
        _dateLabel.textColor=[UIColor whiteColor];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        [_dateLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_start_time_100x33.png"]]];
        [_bg_image addSubview:_dateLabel];
        
        self.costLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 50, 100, 23)];
        _costLabel.textAlignment=NSTextAlignmentCenter;
        _costLabel.textColor=[UIColor whiteColor];
        [_costLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cost_100x23.png"]]];
        [_bg_image addSubview:_costLabel];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 150, 320, 30)];
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        self.clubImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 25, 23)];
        [view addSubview:_clubImage];
        
        self.clubLabel=[[UILabel alloc]initWithFrame:CGRectMake(42, 0, 160, 30)];
        _clubLabel.textColor=[UIColor whiteColor];
        _clubLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        
        self.cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 0, 80, 30)];
        _cityLabel.textColor=[UIColor whiteColor];
        _cityLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        [view addSubview:_cityLabel];
        [view addSubview:_clubLabel];
        [self.bg_image addSubview:view];
        //行程天数
        self.dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(255, 0, 70, 30)];
        _dayLabel.textColor=[UIColor whiteColor];
        _dayLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        [view addSubview:_dayLabel];
        [_dateLabel release];
        
        self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 190, 320, 30)];
        _titleLabel.numberOfLines=0;
        _titleLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        [self.contentView addSubview:_titleLabel];
        
        self.destinationLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 220, 320, 30)];
        _destinationLabel.numberOfLines=0;
        _destinationLabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
        _destinationLabel.textColor=[UIColor grayColor];
        [self.contentView addSubview:_destinationLabel];
        self.typeLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 250, 320, 20)];
        
        
        [self.contentView addSubview:_bg_image];
        
        
        
    }
    return self;
}


-(void)setActivity:(ActivityList *)activity
{
    if (_activity!=activity) {
        [_activity release];
        _activity=[activity retain];

        if ([activity.is_hot isEqual:@"1"]) {
            self.is_hot.image=[UIImage imageNamed:@"img_hot_activity_40x40@2x.png"];
        }else{
            self.is_hot.alpha=0;
        }
        NSString *str=@"出发";
        [str sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:nil size:8]}];
        self.dateLabel.text=[activity.start_time stringByAppendingString:str];
        NSString *str1=@"￥";
        self.costLabel.text=[str1 stringByAppendingString:activity.cost];
        
        self.clubLabel.text=activity.club.title;
    
        self.cityLabel.text=[activity.city stringByAppendingString:str];
        
        self.dayLabel.text=activity.allDays;
        self.destinationLabel.text=[NSString stringWithFormat:@"[ %@ ]",activity.destination];
        self.titleLabel.text=activity.title;
        
        
        //第三方
        NSURL *url2=[NSURL URLWithString:activity.club.logo];
        NSURL *url=[NSURL URLWithString:activity.cover];
        [self.clubImage sd_setImageWithURL:url2];
        
        PlaceholdAnimateView *view=[[PlaceholdAnimateView alloc]initWithFrame:CGRectMake(140, 60, 40, 40)];
        [_bg_image addSubview:view];
        [view start];
        
        [_bg_image sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _bg_image.image=image;
            [view cancel];
        }];
        
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
