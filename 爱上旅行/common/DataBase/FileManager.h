//
//  FileManager.h
//  爱上旅行
//
//  Created by 闪 on 14-12-30.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseManager.h"
@class ActivityList;
@class FileManager;
@interface FileManager : NSObject

@property(nonatomic,retain)NSMutableArray *trailArr;
@property(nonatomic,retain)NSMutableArray *trailLogArr;

+(FileManager*)sharedFileManager;
//将活动详情收藏
-(void)saveActivityDetailWithUserId:(NSString*)userId ActivityId:(NSString*)activityId DetailData:(NSData*)data  Activity:(NSDictionary*)activityDic;
//查询此活动是否已经收藏  为空则表示没有收藏
-(NSString *)querryActivityDataFromDBWithUserId:(NSString*)userId ActivityId:(NSString*)activityId;

//遍历所有的数据
-(NSArray *)querryActivityDataFromDB:(NSString*)userId;
//删除数据库中的数据
-(void)deleteActivityFromDBUserId:(NSString*)userId ActivityId:(NSString*)activityID;



//将游记收藏
-(void)saveTrailLogDetailWithuserID:(NSString*)userID
                         TrailLogId:(NSString*)trailLogId
                           TrailLog:(NSData*)data
                        trailDetail:(NSDictionary*)trailDetail;
//判断此游记是否已收藏  为空则未收藏
-(NSString*)querryTrailLogDataFromDBWithuserID:(NSString*)userID
                                            Id:(NSString *)trailLogId;

//查询所有游记
-(NSArray*)querryTrailLogDataFromDBWithuserID:(NSString*)userID;
//删除游记
-(void)deleteTrailLogFromDBWithUserID:(NSString*)userID
                                   ID:(NSString*)trailLogId;



//路线收藏
-(void)saveTrailDetailWithUserID:(NSString*)userID
                TrailIntroduceId:(NSString*)trailId
                  TrailIntroduce:(NSData*)detail
                    TrailComment:(NSData*)comment
                 TrailOtherTrail:(NSData*)relative;
//返回ID判断  此收藏是否已存在
-(NSString*)querryTrailDetailWithUserID:(NSString*)userID
                                TrailId:(NSString*)trailId;
//查询所有的游记  每行data放在一个数组  这个数组再添加到大数组里
-(NSArray*)querryTrailCollectFromDBWithUserID:(NSString*)userID;
-(void)deleteDetailFromDBWithUserID:(NSString*)userID
                            TrailId:(NSString*)trailId;
@end
