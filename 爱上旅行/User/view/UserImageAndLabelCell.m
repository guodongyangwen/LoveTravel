//
//  UserImageAndLabelCell.m
//  爱上旅行
//
//  Created by gdy on 15-1-1.
//  Copyright (c) 2015年 on the way. All rights reserved.
//

#import "UserImageAndLabelCell.h"

@implementation UserImageAndLabelCell

-(void)dealloc
{
    self.userAvatar = nil;
    self.labelName = nil;
    self.btnQQ = nil;
    self.btnSina = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_profile_default.jpg"]]];
        // Initialization code
        //头像
        self.userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(110, 10, 100, 100)];
        _userAvatar.layer.masksToBounds = YES;
        
        _userAvatar.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
        _userAvatar.layer.borderWidth = 4;
        
        
        _userAvatar.layer.cornerRadius = 50;
        _userAvatar.image = [UIImage imageNamed:@"img_profile_logo"];
        [self.contentView addSubview:_userAvatar];
        [_userAvatar release];
        
        //用户名
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, 220, 30)];
        _labelName.textAlignment  = NSTextAlignmentCenter;
        _labelName.textColor = [UIColor whiteColor];
        _labelName.backgroundColor  = [UIColor clearColor];
        _labelName.text = @"未登录";
        [self.contentView addSubview:_labelName];
        [_labelName release];
        
        
        
        
        
        //QQ登录
        self.btnQQ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnQQ.frame = CGRectMake(40, 160, 100, 30);
        [_btnQQ setBackgroundImage:[UIImage imageNamed:@"btn_qq_login"] forState:UIControlStateNormal];
        [_btnQQ setBackgroundImage:[UIImage imageNamed:@"btn_qq_login_pressed"] forState:UIControlStateSelected];
        [_btnQQ setTitle:@"QQ登录" forState:UIControlStateNormal];
        _btnQQ.titleLabel.textColor = [UIColor whiteColor];
        //登录按钮上面的字
        
        [self.contentView addSubview:_btnQQ];
        //sina登录
        self.btnSina = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnSina.frame = CGRectMake(180, 160, 100, 30);
        _btnSina.userInteractionEnabled = YES;
        [_btnSina setBackgroundImage:[UIImage imageNamed:@"btn_sina_login"] forState:UIControlStateNormal];
        [_btnSina setBackgroundImage:[UIImage imageNamed:@"btn_sina_login_pressed"] forState:UIControlStateSelected];
        
        //登录按钮上面的字
        [_btnSina setTitle:@"Sina登录" forState:UIControlStateNormal];
        [_btnSina setTitle:@"Sina登录" forState:UIControlStateSelected];
        _btnSina.titleLabel.textColor = [UIColor whiteColor];
        //添加按钮事件
        [self.contentView addSubview:_btnSina];
        

    }
    return self;
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
