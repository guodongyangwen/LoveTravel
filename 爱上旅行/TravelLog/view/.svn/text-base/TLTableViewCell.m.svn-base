//
//  TLTableViewCell.m
//  爱上旅行
//
//  Created by 齐浩 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TLTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TLTableViewCell
-(void)dealloc
{
    self.namaLable = nil;
    self.created_dateLable = nil;
    self.total_daysLable = nil;
    self.nicknameLabl = nil;
    self.avatarImage = nil;
    self.photo_numberLable = nil;
    self.travelLog = nil;
    self.author = nil;
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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bg_imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 310, 150)];
        self.bg_imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.bg_imageView];
        [self.bg_imageView release];
        //头像
        _avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(260, 125, 40, 40)];
        _avatarImage.layer.cornerRadius = 20;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.backgroundColor = [UIColor lightGrayColor];
        [self.bg_imageView addSubview:_avatarImage];
        [_avatarImage release];
        
        //name
        _namaLable  = [[UILabel alloc]initWithFrame:CGRectMake(10, 95, 230, 60)];
        _namaLable.numberOfLines = 0;
        _namaLable.shadowOffset =CGSizeMake(0.6, 0.8);
        _namaLable.shadowColor = [UIColor blackColor];
        _namaLable.textColor = [UIColor whiteColor];
        _namaLable.font = [UIFont systemFontOfSize:14];
        _namaLable.backgroundColor = [UIColor clearColor];
        [self.bg_imageView addSubview:_namaLable];
        [_namaLable release];
        
        //时间以及图片数
        _created_dateLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 80, 20)];
        _created_dateLable.font = [UIFont systemFontOfSize:12];

        [self.contentView addSubview:_created_dateLable];
        [_created_dateLable release];
        //
        _total_daysLable = [[UILabel alloc]initWithFrame:CGRectMake(95, 160, 20, 20)];
        _total_daysLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_total_daysLable];
        [_total_daysLable release];
        //
        _photo_numberLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 160, 40, 20)];
        _photo_numberLable.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_photo_numberLable];
        [_photo_numberLable release];
        
        //
        _nicknameLabl = [[UILabel alloc]initWithFrame:CGRectMake(170, 160, 100, 20)];
        _nicknameLabl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nicknameLabl];
        [_nicknameLabl release];
        UILabel *byLable=[[UILabel alloc]initWithFrame:CGRectMake(155, 160, 15, 20)];
        byLable.text = @"by";
        byLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:byLable];
        [byLable release];
        
        
    }
    return self;
}

-(void)setTravelLog:(TravelLog *)travelLog
{
    if (_travelLog != travelLog) {
        
        [_travelLog release];
        _travelLog = [travelLog retain];
        //名称
        self.namaLable.text = _travelLog.name;
        //图片数
        NSString *str = @"图";
        self.photo_numberLable.text = [[self.travelLog.photo_number stringValue] stringByAppendingString:str ];
        //天数
        self.total_daysLable.text = [NSString stringWithFormat:@"%@天", _travelLog.total_days ];
        //昵称
        self.nicknameLabl.text = self.travelLog.author.nickname;
//        NSLog(@"昵称:%@",self.nicknameLabl.text);
        //创建时间
        self.created_dateLable.text = [NSString stringWithFormat:@"%@ .", _travelLog.start_date ];
        
        //图片缓冲视图
        PlaceholdAnimateView *place =[[PlaceholdAnimateView alloc]initWithFrame:CGRectMake(140, 70, 40, 40)];
        [self.bg_imageView addSubview:place];
        [place start];
        
        //背景图片
        NSURL *url = [NSURL URLWithString:_travelLog.cover];
        [self.bg_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [place cancel];
            }];
        //头像
        NSURL *url2 =[NSURL URLWithString:_travelLog.author.avatar];
        [self.avatarImage sd_setImageWithURL:url2];
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
