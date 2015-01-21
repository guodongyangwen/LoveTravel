//
//  customizeCommentCell.m
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "customizeCommentCell.h"
#import "CrowdView.h"

@interface customizeCommentCell()
@property(nonatomic,retain)CrowdView* crowdView;

@end

@implementation customizeCommentCell

-(void)dealloc
{
    self.commentView = nil;
    self.label_suit = nil;
    self.comment = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //布局
        self.commentView  = [[CustomizeCommentView alloc] initWithFrame:CGRectMake(10, 10, 300, 0)];
        [self.contentView addSubview:_commentView];
        [_commentView release];
        //适合人群(y坐标，需要自适应）
        self.label_suit = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
        _label_suit.text = @"适合人群";
        _label_suit.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_label_suit];
        [_label_suit release];
        //添加  适合人群按钮
        
    }
    return self;
}


//重写setter方法，设置数据
-(void)setComment:(CommentModal *)comment
{
    if(_comment != comment)
    {
        [_comment release ];
        _comment = [comment retain];
    
    [_commentView.imageView_User sd_setImageWithURL:[NSURL URLWithString:comment.auther.avatar]];
    
    _commentView.label_nickName.text = comment.auther.nickname;
    _commentView.label_createdDate.text = comment.created_date;
    _commentView.label_commentContent.text = comment.comment;
    //星星
    [self setScore:comment.trail_score];
    
    CGFloat height = [NSString getHeightWithText:comment.comment ViewWidth:300 fontSize:15];
    _commentView.frame = CGRectMake(0, 0, 300, 85+height);
    
    CGRect frame = _commentView.label_commentContent.frame ;
    frame.size.height = height;
    _commentView.label_commentContent.frame = frame;
    //修改适合人群额y坐标
    CGRect frame_suit  = _label_suit.frame;
    frame_suit.origin.y = height+85;
    _label_suit.frame = frame_suit;

    
    
    //适合人群 按钮
    for(int i=0;i<comment.crowdArr.count;i++)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //设置属性
        button.layer.cornerRadius = 6;
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_crowd_button.png"]];
        NSString* title = [[comment.crowdArr objectAtIndex:i] name];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(80+55*(i%4),85+height + 35*(i/4),50,30);
        //添加事件
        [button addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }

    }

}

//按钮点击事件
-(void)btnHandle:(UIButton*)btn
{
    self.crowdView = [[CrowdView alloc] initWithFrame:CGRectMake(320, 0, 260, 504)];
    //传值
    //NSLog(@"------%@",_comment.crowdArr);
    self.crowdView.crowdArr = _comment.crowdArr;
    
    
    _crowdView.backgroundColor = [UIColor whiteColor];
    [self.superview.superview addSubview:_crowdView];
    
    //添加手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [_crowdView addGestureRecognizer:tap];
    [tap release];
    
    
    //设置动画
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
    animation.autoreverses = NO;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
    animation.duration = 0.4;
    [_crowdView.layer addAnimation:animation forKey:@"position"];
    _crowdView.center = CGPointMake(190, 252);
}


//手势事件处理
-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    //设置动画
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];//中心点
    animation.autoreverses = NO;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(190, 252)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(450, 252)];
    animation.duration = 0.4;
    [_crowdView.layer addAnimation:animation forKey:@"position"];
    _crowdView.center = CGPointMake(450, 252);
    
    //删除的时候，一闪而过，
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_crowdView removeFromSuperview];
    });
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
                UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+20*i, 50, 20, 20)];
                imageView.image = [UIImage imageNamed:@"img_star_half_14x14@2x"];
                [self.contentView addSubview:imageView];
                [imageView release];
                break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75+20*i, 50, 20, 20)];
            imageView.image = [UIImage imageNamed:@"img_star_14x14@2x"];
            [self.contentView addSubview:imageView];
            [imageView release];
        }
    }
    else if(s>7 && s<=8)//四星
    {
        for(int i=0;i<4;i++)
        {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+20*i, 50, 20, 20)];
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
