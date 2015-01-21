//
//  customizeCommentCell.h
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomizeCommentView.h"//使用以前创建的  评论视图，来作为  评论cell 的一部分
#import "CommentModal.h"//评论modal

@interface customizeCommentCell : UITableViewCell
@property(nonatomic,retain)CustomizeCommentView* commentView;//评论视图
@property(nonatomic,retain)UILabel* label_suit;//适合人群label
@property(nonatomic,retain)CommentModal* comment;//评论数据

-(void)dealloc;
@end
