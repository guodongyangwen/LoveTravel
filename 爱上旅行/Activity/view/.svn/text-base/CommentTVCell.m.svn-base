//
//  CommentTVCell.m
//  爱上旅行
//
//  Created by 闪 on 14-12-30.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CommentTVCell.h"
#import "CommentModal.h"

@interface CommentTVCell ()
@property(nonatomic,retain)UIImageView *imageV;
@property(nonatomic,retain)UILabel *nameLabel,*dateLabel,*contentLabel;

@end

@implementation CommentTVCell
-(void)dealloc
{
    self.comment = nil;
    self.imageV = nil;
    self.nameLabel = nil;
    self.dateLabel = nil;
    self.contentLabel = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
        _imageV.layer.cornerRadius=25;
        _imageV.layer.masksToBounds=YES;
        [self.contentView addSubview:_imageV];
        [_imageV release];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 12, 150, 30)];
        _nameLabel.textColor=[UIColor cyanColor];
        _nameLabel.font=[UIFont fontWithName:nil size:14];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 40, 100, 25)];
        _dateLabel.font=[UIFont fontWithName:nil size:12];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        //自适应
        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 75,300 , 10)];
        _contentLabel.font=[UIFont fontWithName:nil size:14];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel release];
        
    }
    return self;
}

-(void)setComment:(CommentModal *)comment
{
    if (_comment!=comment) {
        [_comment release];
        _comment=[comment retain];
        
        CGFloat height=[NSString getHeightWithText:comment.comment ViewWidth:300 fontSize:14];
        NSLog(@"%@",comment.comment);
        CGRect frame=self.contentLabel.frame;
        frame.size.height=height;
        _contentLabel.frame=frame;
        _contentLabel.text=comment.comment;
        
        NSURL *url=[NSURL URLWithString:comment.auther.avatar];
        [_imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content@2x~ipad.png"]];
        _nameLabel.text=comment.auther.nickname;
        
        _dateLabel.text=comment.created_date;
        
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
