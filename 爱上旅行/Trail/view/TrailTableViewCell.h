//
//  TrailTableViewCell.h
//  爱上旅行
//
//  Created by gdy on 14-12-25.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrailTableViewCell : UITableViewCell
@property(nonatomic,copy)NSString* isNew;
@property(nonatomic,retain)UIImageView* imageView_cover;//封面
@property(nonatomic,retain)UILabel* label_name;//路线名称
@property(nonatomic,retain)UILabel* label_destination;//目的地
@property(nonatomic,retain)UIImageView* imageView_destionation;//目的地图片
@property(nonatomic,retain)UIImageView* imageView_activity;//活动图片
@property(nonatomic,retain)UILabel* label_number;//活动个数

//评分
@property(nonatomic,retain)NSString* score;

-(void)dealloc;

@end
