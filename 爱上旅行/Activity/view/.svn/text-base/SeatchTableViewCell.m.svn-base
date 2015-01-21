//
//  SeatchTableViewCell.m
//  爱上旅行
//
//  Created by 闪 on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "SeatchTableViewCell.h"


@interface SeatchTableViewCell ()

@end
@implementation SeatchTableViewCell
-(void)dealloc
{
    self.dataArr = nil;
    self.btnArr = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//注册的自定义cell不走initwithstyle方法
-(void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr!=dataArr) {
        [_dataArr release];
        _dataArr=[dataArr retain];
    }
    
    self.btnArr=[[NSMutableArray alloc]init];
    for (int i=0; i<[_dataArr count]; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(10+(i%4)*70, i/4*40, 60, 30);
        btn.titleLabel.textColor=[UIColor cyanColor];
        [self.contentView addSubview:btn];
        [_btnArr addObject:btn];
    }

    
    
    for (int i=0; i<[_btnArr count]; i++) {
        [_btnArr[i] setTitle:[dataArr objectAtIndex:i] forState:UIControlStateNormal];
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
