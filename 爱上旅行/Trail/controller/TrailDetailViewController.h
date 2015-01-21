//
//  TrailDetailViewController.h
//  爱上旅行
//
//  Created by gdy on 14-12-26.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "MyDetailViewController.h"
#import "RequestHandle.h"
#import "CUSFlashLabel.h"
#import "TrailDetail.h"
#import "CrowdView.h"
#import "CommentModal.h"
#import "CustomizeCommentView.h"//自定义评论视图
#import "Trail.h"
#import "CustomizeTrailCoverView.h"
#import "CommentTViewController.h"//评论VC
#import "PictureViewController.h"
#import "BufferingView.h"
#import "PlaceholdAnimateView.h"
#import "UMSocialBar.h"
#import "UMSocialData.h"
#import "UMSocialAccountManager.h"
//数据库
#import "FileManager.h"
#import "DataBaseManager.h"

@interface TrailDetailViewController : MyDetailViewController<RequestHandleDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>
{
    UMSocialData *_socialData;
    UMSocialBar *_socialBar;
}
@property(nonatomic,retain)NSString* trailId;//路线id（用于请求路线详情）
@property(nonatomic,retain)NSString* titleNB;//NB标题

//定义三个data   记录解析前的数据 用于收藏
@property(nonatomic,retain)NSData* dataDetail;
@property(nonatomic,retain)NSData* dataComment;
@property(nonatomic,retain)NSData* dataRelative;


@property(nonatomic,retain)NSArray* dataArr;//数据数组

@property(nonatomic)BOOL isRequest;//是否请求


-(void)dealloc;
@end
