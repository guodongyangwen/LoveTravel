//
//  MyTrailTableViewCell.m
//  爱上旅行
//
//  Created by gdy on 15-1-2.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "MyTrailTableViewCell.h"

@implementation MyTrailTableViewCell

-(void)dealloc
{
    self.imageV = nil;
    self.labelName = nil;
    self.imagePosition = nil;
    self.labelDestination = nil;
    self.trail = nil;
    self.score = nil;
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
        self.imagePosition = [[UIImageView alloc] initWithFrame:CGRectMake(100, 45, 12, 12)];
        _imagePosition.image = [UIImage imageNamed:@"icon_location_gray_12x12@2x"];
        [self.contentView addSubview:_imagePosition];
        [_imagePosition release];
        
        //目的地
        self.labelDestination = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 200, 20)];
        _labelDestination.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_labelDestination];
        [_labelDestination release];
        //星星
    }
    return self;
}


-(void)setTrail:(TrailDetail *)trail
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:trail.cover]];
    self.labelName.text = trail.name;
    self.labelDestination.text = trail.destination;
    [self setScore:trail.trail_score];
}

//设置评分
-(void)setScore:(NSString *)score
{
    float s = score.floatValue;
    if(s>9)//五颗星
    {
        for(int i=0;i<5;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100+20*i, 65, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>8 && s<=9)//四星半
    {
        for(int i=0;i<5;i++)
        {
            if(i==4)
            {
                UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100+20*i, 65, 20, 20)];
                imageView.image = [UIImage imageNamed:@"img_star_half_14x14@2x"];
                [self.contentView addSubview:imageView];
                [imageView release];
                break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100+20*i, 65, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>7 && s<=8)//四星
    {
        for(int i=0;i<4;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100+20*i, 65, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }
        
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
