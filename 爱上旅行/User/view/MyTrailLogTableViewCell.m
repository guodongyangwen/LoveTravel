//
//  MyTrailLogTableViewCell.m
//  爱上旅行
//
//  Created by gdy on 15-1-2.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "MyTrailLogTableViewCell.h"

@implementation MyTrailLogTableViewCell

-(void)dealloc
{
    self.trailDetail = nil;
    self.labelTimeAndDaysAndPictures = nil;
    self.labelName = nil;
    self.labelUserName = nil;
    self.imageUser = nil;
    self.imageV = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //布局
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 90, 90)];
        [self.contentView addSubview:_imageV];
        [_imageV release];
        //名字
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20)];
        _labelName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_labelName];
        [_labelName release];
        //图片
        self.imageUser = [[UIImageView alloc] initWithFrame:CGRectMake(90, 40, 30, 30)];
        _imageUser.image = [UIImage imageNamed:@"btn_navigationbar_me_80x49@2x.png"];
        [self.contentView addSubview:_imageUser];
        [_imageUser release];
        
        //用户名
        self.labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 200, 20)];
        _labelUserName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_labelUserName];
        [_labelUserName release];
        
        //日期和  图片个数
        self.labelTimeAndDaysAndPictures = [[UILabel alloc] initWithFrame:CGRectMake(100, 65, 200, 20)];
        _labelTimeAndDaysAndPictures.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_labelTimeAndDaysAndPictures];
        [_labelTimeAndDaysAndPictures release];
        
    }
    return self;
}


-(void)setTrailDetail:(TravelLog *)trailDetail
{
    //NSLog(@"dic:%@",trailDetail.author.nickname);
    [_imageV sd_setImageWithURL:[NSURL URLWithString:trailDetail.cover]];
    _labelName.text = trailDetail.name;
    _labelUserName.text = trailDetail.nickname;
    //时间，天数，图片个数
    NSString* text = [trailDetail.start_date stringByAppendingString:[NSString stringWithFormat:@" . %@天%@图",trailDetail.total_days,trailDetail.photo_number]];
    _labelTimeAndDaysAndPictures.text = text;
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
