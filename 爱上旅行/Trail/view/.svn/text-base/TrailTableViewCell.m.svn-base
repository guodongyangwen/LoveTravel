//
//  TrailTableViewCell.m
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "TrailTableViewCell.h"

@implementation TrailTableViewCell

-(void)dealloc
{
    self.isNew = nil;
    self.imageView_cover = nil;
    self.label_name = nil;
    self.label_number = nil;
    self.label_destination = nil;
    self.imageView_activity = nil;
    self.imageView_destionation = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self layoutSubview];
    }
    return self;
}

//布局子视图
-(void)layoutSubview
{
    //封面
    self.imageView_cover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,180)];
    [_imageView_cover setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [self.contentView addSubview:_imageView_cover];
    [_imageView_cover release];
    //透明视图容器
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(60, 40, 200, 80)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [_imageView_cover addSubview:view];
    [view release];
    
    UIView* whiteLine = [[UIView alloc] initWithFrame:CGRectMake(0, 79, 200, 1)];
    whiteLine.backgroundColor = [UIColor whiteColor];
    [view addSubview:whiteLine];
    [whiteLine release];
    
    //路线名称
    self.label_name = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 160, 50)];
    _label_name.text = @"龙虎山";
    _label_name.textColor = [UIColor whiteColor];
    _label_name.font = [UIFont systemFontOfSize:20];
    _label_name.backgroundColor = [UIColor clearColor];
    _label_name.textAlignment = UITextAlignmentCenter;
    [view addSubview:_label_name];
    [_label_name release];
    
    
    //目的地
    self.label_destination = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 160, 20)];
    _label_destination.textColor = [UIColor whiteColor];
    _label_destination.text = @"安徽 安庆 潜山";
    _label_destination.font = [UIFont systemFontOfSize:14];
    _label_destination.textAlignment = UITextAlignmentCenter;
    [_label_destination setBackgroundColor:[UIColor clearColor]];
    [view addSubview:_label_destination];
    
}

//设置评分
-(void)setScore:(NSString *)score
{
    float s = score.floatValue;
    if(s>9)//五颗星
    {
        for(int i=0;i<5;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110+20*i, 120, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_18x18@2x.png"];
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
                UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110+20*i, 120, 20, 20)];
                imageView.image = [UIImage imageNamed:@"img_star_half_18x18@2x.png"];
                [self.contentView addSubview:imageView];
                [imageView release];
                break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110+20*i, 120, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_18x18@2x.png"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>7 && s<=8)//四星
    {
        for(int i=0;i<5;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110+20*i, 120, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_18x18@2x.png"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }

    }
}

//是否最新
-(void)setIsNew:(NSString *)isNew
{
   // NSLog(@"%@",isNew);
    
    if(isNew.intValue == 1)
    {
        //添加图片
        UIImageView* imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageV.image = [UIImage imageNamed:@"img_new_route_40x40@2x.png"];
        [self.contentView addSubview:imageV];
        [imageV release];
    }
    else
    {
        //[imageV removeFromSuperview];
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
