//
//  CustomizeCommentView.m
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CustomizeCommentView.h"

@interface CustomizeCommentView()

@end

@implementation CustomizeCommentView

-(void)dealloc
{
    
    self.imageView_User = nil;
    self.label_commentContent = nil;
    self.label_createdDate =  nil;
    self.label_nickName = nil;
    self.comment = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //布局,
        //头像
        self.imageView_User = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 60, 60)];
        [_imageView_User setBackgroundColor:[UIColor lightGrayColor]];
        _imageView_User.layer.masksToBounds = YES;
        _imageView_User.layer.cornerRadius = 30;
        [self addSubview:_imageView_User];
        [_imageView_User release];
        //昵称
        self.label_nickName = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 200, 30)];
        _label_nickName.font = [UIFont systemFontOfSize:15];
        [self addSubview:_label_nickName];
        [_label_nickName release];
        //星星（单独处理)
        
        //创建日期
        self.label_createdDate = [[UILabel alloc] initWithFrame:CGRectMake(210, 40, 100, 45)];
        _label_createdDate.font = [UIFont systemFontOfSize:10];
        [self addSubview:_label_createdDate];
        [_label_createdDate release];
        
        //评论内容(需要自适应高度）
        self.label_commentContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 0)];
        _label_commentContent.numberOfLines = 0;
        _label_commentContent.font = [UIFont fontWithName:nil size:15];
        [self addSubview:_label_commentContent];
        [_label_commentContent release];
        
    }
    return self;
}


#pragma mark 设置评论
-(void)setComment:(CommentModal *)comment
{
    if(_comment != comment)
    {
        [_comment release];
        _comment = [comment retain];
        
        //赋值
        //头像
        [_imageView_User sd_setImageWithURL:[NSURL URLWithString:comment.auther.avatar]];
        //昵称
        _label_nickName.text = comment.auther.nickname;
        //创建星星
        [self setScore:comment.trail_score];
        //创建日期
        _label_createdDate.text = comment.created_date;
        
        //评论内容
        //获取高度
        CGFloat height = [NSString getHeightWithText:comment.comment ViewWidth:300 fontSize:15];
        CGRect frame =  _label_commentContent.frame;
        frame.size.height = height;
        _label_commentContent.frame = frame;
        //设置文本呢
        _label_commentContent.text = comment.comment;
    }
}


-(void)setScore:(NSString *)score
{
    float s = score.floatValue;
    if(s>9)//五颗星
    {
        for(int i=0;i<5;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+20*i, 50, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>8 && s<=9)//四星半
    {
        for(int i=0;i<5;i++)
        {
            if(i==4)
            {
                UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+20*i, 50, 20, 20)];
                imageView.image = [UIImage imageNamed:@"img_star_half_14x14@2x"];
                [self addSubview:imageView];
                [imageView release];
                break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 50, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>7 && s<=8)//四星
    {
        for(int i=0;i<4;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+20*i, 50, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self addSubview:imageView];
            [imageView release];
        }
        
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
