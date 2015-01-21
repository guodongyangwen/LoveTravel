//
//  CommentTViewController.h
//  爱上旅行
//
//  Created by gdy on 14-12-28.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHandle.h"
#import "CUSFlashLabel.h"
#import "RequestHandle.h"
#import "CommentModal.h"//评论modal
#import "customizeCommentCell.h"//自定义评论cell


@interface CommentTViewController : UIViewController<RequestHandleDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSString* commentTrail;//要评论的 路线名称
@property(nonatomic,copy)NSString* trailId;//路线id

-(void)dealloc;

@end
