//
//  SeatchTableViewCell.h
//  爱上旅行
//
//  Created by 闪 on 14-12-29.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatchTableViewCell : UITableViewCell

@property(nonatomic,retain)NSArray *dataArr;  //title数组

@property(nonatomic,retain)NSMutableArray *btnArr;//按钮数组

-(void)dealloc;
@end
