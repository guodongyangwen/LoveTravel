//
//  HandViewCell.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "HandViewCell.h"

@implementation HandViewCell

-(void)dealloc
{
    self.tableView = nil;
    self.destinationLable = nil;
    self.created_dateLable = nil;
    self.avatarImageView = nil;
    self.nicknameLable = nil;
    self.photo_numberLable = nil;
    self.nameLable = nil;
    self.allDays = nil;
    self.sourceLable = nil;
    self.travelLog = nil;
    self.detailTL = nil;
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
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bg_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 170)];
        self.bg_imageView.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:self.bg_imageView];
        [self.bg_imageView release];
        
        UILabel *backView = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 320, 30)];
        backView.backgroundColor = [UIColor grayColor];
        backView.alpha = 0.3;
        [self.bg_imageView addSubview:backView];
        [backView release];
        //头像
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 115, 46, 46)];
        _avatarImageView.layer.cornerRadius = 23;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor=[UIColor lightGrayColor];
        [self.bg_imageView addSubview:_avatarImageView];
        [_avatarImageView release];
        
        
        //昵称
        _nicknameLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 145, 120, 20)];
        //赋值
        _nicknameLable.font= [UIFont systemFontOfSize:12];
        _nicknameLable.textColor =[UIColor whiteColor];
        [self.bg_imageView addSubview:_nicknameLable];
        [_nicknameLable release];

        
        //游记名称
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(8, 175, 270, 50)];
        _nameLable.numberOfLines = 0;
        _nameLable.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_nameLable];
        [_nameLable release];
        //目的地
        _destinationLable = [[UILabel alloc]initWithFrame:CGRectMake(8, 220, 200, 20)];
        _destinationLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_destinationLable];
        [_destinationLable release];
        //创建时间
        _created_dateLable = [[UILabel alloc]initWithFrame:CGRectMake(8, 240, 80, 20)];
        _created_dateLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_created_dateLable];
        [_created_dateLable release];
        //天数
        _allDays = [[UILabel alloc]initWithFrame:CGRectMake(88, 240, 30, 20)];
        _allDays.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_allDays];
        [_allDays release];
        //照片数
        _photo_numberLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 240, 60, 20)];
        _photo_numberLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_photo_numberLable];
        [_photo_numberLable release];

        
    }
    
    return self;


}
-(void)setTravelLog:(TravelLog *)travelLog
{
    if (_travelLog !=travelLog) {
        
        [_travelLog release];
        _travelLog = [travelLog retain];

        
        self.nicknameLable.text = [NSString stringWithFormat:@"by: %@", _travelLog.nickname ];
        self.nameLable.text = _travelLog.name;
        self.created_dateLable.text =[NSString stringWithFormat:@"%@ .", _travelLog.start_date ];
        self.allDays.text = [NSString stringWithFormat:@"%@天", _travelLog.total_days ];
        self.photo_numberLable.text = [NSString stringWithFormat:@" .%@图", _travelLog.photo_number ];
        self.destinationLable.text = _travelLog.destination;
        
        //重新请求头像
        NSURL *url = [NSURL URLWithString:_travelLog.avatar];
        [self.avatarImageView sd_setImageWithURL:url];
    
        //重新请求背景图片
        NSURL *url2 = [NSURL URLWithString:_travelLog.cover];
        [self.bg_imageView sd_setImageWithURL:url2];
        
        
        
    
    }




}

-(void)setDetailTL:(DetailTL *)detailTL
{
    if (_detailTL != detailTL)
    {
        [_detailTL release];
        _detailTL=[detailTL retain];
     

        //来源
       self.sourceLable.text = [NSString stringWithFormat:@"From: %@", _detailTL.source ];
      NSLog(@"来源:%@",_detailTL.source);
        
        [self setTravelLog:_detailTL.trailLog];
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
