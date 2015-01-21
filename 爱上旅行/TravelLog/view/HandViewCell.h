//
//  HandViewCell.h
//  爱上旅行
//
//  Created by 齐浩 on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "ASLXTableViewCell.h"
#import "DetailTL.h"
#import "TravelLog.h"
#import "UIImageView+WebCache.h"

@interface HandViewCell : ASLXTableViewCell
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)UILabel *created_dateLable;//创建时间
@property(nonatomic,retain)UILabel *destinationLable; //目的地
@property(nonatomic,retain)UIImageView *avatarImageView; //用户头像
@property(nonatomic ,retain)UILabel *nicknameLable; //昵称
@property(nonatomic,retain)UILabel *photo_numberLable; //图片数量
@property(nonatomic,retain)UILabel *nameLable; //游记名称
@property(nonatomic,retain)UILabel *allDays; //天数
@property(nonatomic,retain)UILabel *sourceLable; //来源


@property(nonatomic,retain)TravelLog *travelLog;
@property(nonatomic,retain)DetailTL *detailTL;
@end
