//
//  CrowdView.m
//  爱上旅行
//
//  Created by gdy on 14-12-27.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "CrowdView.h"
#import "NSString+HeightHandle.h"

@interface CrowdView ()
@property(nonatomic,retain)NSDictionary* crowdDesDictionary;
@end

@implementation CrowdView

-(void)dealloc
{
    self.crowdArr = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.crowdDesDictionary = [[NSDictionary alloc] init];
        _crowdDesDictionary = @{
            @"休闲派":@"新驴或是看淡风光之后返璞归真的老驴，轻松享受户外活动的乐趣",
            @"技术流":@"对各类户外运动有更高的追求；持续进阶，不断磨练体能与技巧",
            @"重装客":@"体能超好，装备齐全，野外生存能力强，不重装就不舒服的老驴",
            @"探险家":@"极限户外挑战者，酷爱探索未知的领域；无人区才是我的家园",
            @"享乐派":@"进山不怕吃苦，出了山就该享受； 吃美食，住五星，出行头等舱",
            @"户二代":@"成长中的户外小驴",
            @"人文客":@"人文元素给户外活动注入灵魂；我是有文化爱历史的驴子",
            @"摄影控":@"酷爱摄影，为拍摄完美大片不惜行走天涯",
            @"独行侠":@"野外生存能力强，喜欢solo，享受孤独的旅途"
        };
    }
    return self;
}

-(void)setCrowdArr:(NSMutableArray *)crowdArr
{
    if(_crowdArr != crowdArr)
    {
        [_crowdArr release];
        _crowdArr = [crowdArr retain];
    }
    //布局
    [self layoutViews];
}

-(void)layoutViews
{
    for(int i=0;i<_crowdArr.count;i++)
    {
        //设置标题
        UILabel* label_title = [[UILabel alloc] initWithFrame:CGRectMake(10+85*(i%3), 10+160*(i/3), 80, 30)];
        label_title.text = [[_crowdArr objectAtIndex:i] name];
        label_title.textAlignment = UITextAlignmentCenter;
        
        //容器
        UILabel* label_container = [[UILabel alloc] initWithFrame:CGRectMake(10+85*(i%3), 45+160*(i/3), 80, 115)];
        
        
        //派系描述
        //获取描述
        NSString* des = [_crowdDesDictionary objectForKey:[[_crowdArr objectAtIndex:i] name]];
        UILabel* label_des = [[UILabel alloc] initWithFrame:CGRectMake(5,10,70,95)];
        label_des.font = [UIFont fontWithName:nil size:13];
        label_des.text = des;
        label_des.numberOfLines = 0;
        
        //背景图片
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+85*(i%3), 10+160*(i/3), 80, 150)];
        //选取不同的图片
        if(i%2 == 0)
        {
            imageView.image = [UIImage imageNamed:@"img_tag_white_81x157@2x"];
            label_title.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_tag_blue_81x157@2x"]];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"img_tag_blue_81x157@2x"];
            label_title.textColor = [UIColor whiteColor];
            label_container.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        }
        
        
        
        
        [self addSubview:imageView];
        [self addSubview:label_title];
        [self addSubview:label_container];
        [label_container addSubview:label_des];
        [imageView release];
        [label_title release];
        [label_container release];
        [label_des release];
    }
}


@end
