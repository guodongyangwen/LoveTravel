//
//  CustomizeTrailTypeTableViewCell.m
//  爱上旅行
//
//  Created by gdy on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CustomizeTrailTypeTableViewCell.h"

@implementation CustomizeTrailTypeTableViewCell

-(void)dealloc
{
    self.imageV = nil;
    self.trailType = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 180)];
        _imageV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _imageV.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageV];
        [_imageV release];
    }
    return self;
}

-(void)setTrailType:(TrailType *)trailType
{
    if(_trailType != trailType)
    {
        [_trailType release];
        _trailType = [trailType retain];
        
        PlaceholdAnimateView* place = [[PlaceholdAnimateView alloc] initWithFrame:CGRectMake(140, 70, 40, 40)];
        [_imageV addSubview:place];
        [place start];
        
        [_imageV sd_setImageWithURL:[NSURL URLWithString:_trailType.url] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [place cancel];
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
