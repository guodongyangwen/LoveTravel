//
//  FileManager.m
//  爱上旅行
//
//  Created by 闪 on 14-12-30.
//  Copyright (c) 2014年 on the way. All rights reserved.
//

#import "FileManager.h"
#import "ActivityList.h"
static FileManager *fileManger;
@implementation FileManager

+(FileManager*)sharedFileManager
{
    @synchronized(self){
      if (fileManger) {
         
          return fileManger;
      }
        
      fileManger=[[FileManager alloc] init];
      return fileManger;
      
    }
    
}
//将活动详情收藏
-(void)saveActivityDetailWithUserId:(NSString*)userId ActivityId:(NSString*)activityId DetailData:(NSData*)data  Activity:(NSDictionary*)activityDic
{
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sqlStr=@"INSERT INTO Activity VALUES(?,?,?,?)";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        //绑定
        sqlite3_bind_text(stmt, 1, [userId UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [activityId UTF8String], -1, nil);
        sqlite3_bind_blob(stmt, 3, data.bytes,(int)data.length, nil);
        //activityDic 归档
        NSMutableData *data1=[[NSMutableData alloc]init];
    
        NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data1];
        [archiver encodeObject:activityDic forKey:@"activity"];
        [archiver finishEncoding];
        sqlite3_bind_blob(stmt, 4, data1.bytes, (int)data1.length, nil);
        [archiver release];
    }
    
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    
}
//查询此活动是否已经收藏  为空则表示没有收藏
-(NSString *)querryActivityDataFromDBWithUserId:(NSString*)userId ActivityId:(NSString*)activityId
{
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"SELECT activityId FROM Activity WHERE  userId=? AND activityId=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [userId UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [activityId UTF8String], -1, nil);
    }
    NSString *ID = nil;
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        ID=[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 0)];
    }
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    return ID;
}

//遍历所有的数据
-(NSArray *)querryActivityDataFromDB:(NSString*)userId
{
    //存储遍历到的数据data
    NSMutableArray *dataArr=[[NSMutableArray alloc]init];
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"SELECT detailData,activity FROM Activity WHERE userId=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [userId UTF8String], -1, nil);
        
        NSDictionary *activityDic;
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSMutableArray *detailArr=[[NSMutableArray alloc]init];

            activityDic=[[NSDictionary alloc]init];
            
            NSData *data1=[NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSData *data2=[NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            //反归档
            NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
            activityDic = [unarchiver decodeObjectForKey:@"activity"];
            [unarchiver finishDecoding];
            
            //添加到返回数组
            [detailArr addObject:data1];
            [detailArr addObject:activityDic];
            [dataArr addObject:detailArr];  //存放一个详情页面的完整信息
           
        }
        
    }
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    
    return dataArr;
}
//删除数据库中的数据
-(void)deleteActivityFromDBUserId:(NSString*)userId ActivityId:(NSString*)activityID
{
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"DELETE FROM Activity WHERE userId=? AND activityId=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [userId UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [activityID UTF8String], -1, nil);
    }
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        
    }
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];

}









//将游记收藏
-(void)saveTrailLogDetailWithuserID:(NSString*)userID
                         TrailLogId:(NSString*)trailLogId
                           TrailLog:(NSData*)data
                        trailDetail:(NSDictionary*)trailDetail;
{
    //NSLog(@"dic:%@",trailDetail);
    NSMutableData* dataDetail = [NSMutableData data];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataDetail];
    [archiver encodeObject:trailDetail forKey:@"trailLog"];
    [archiver finishEncoding];
    
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sqlStr=@"INSERT INTO TrailLog VALUES(?,?,?,?)";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    if (flag == SQLITE_OK)
    {
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailLogId UTF8String], -1, nil);
        sqlite3_bind_blob(stmt, 3, data.bytes,(int)data.length, nil);
        sqlite3_bind_blob(stmt, 4, dataDetail.bytes, (int)dataDetail.length, nil);
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
}
//判断此游记是否已收藏  为空则未收藏
-(NSString*)querryTrailLogDataFromDBWithuserID:(NSString*)userID
                                            Id:(NSString *)trailLogId
{
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"SELECT ID FROM TrailLog WHERE userID=?  AND ID=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailLogId UTF8String], -1, nil);
    }
    NSString *ID= nil;
    while (sqlite3_step(stmt)==SQLITE_ROW) {

        ID=[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 0)];
    }
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    return ID;

}

//查询所有游记
-(NSArray*)querryTrailLogDataFromDBWithuserID:(NSString*)userID
{
    self.trailLogArr=[[NSMutableArray alloc]init];
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"SELECT trailLog,trailDetail FROM TrailLog WHERE userID=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSData *data1 = [NSData data];
            NSData *data2 = [NSData data];
            NSMutableArray* dataArr = [[NSMutableArray alloc] init];
            data1=[NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            data2 = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data2];
            NSDictionary* dic = [unArchiver decodeObjectForKey:@"trailLog"];
            [unArchiver finishDecoding];
            
            [dataArr addObject:data1];
            [dataArr addObject:dic];
            
            [_trailLogArr addObject:dataArr];
            
        }
    }
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    
    return _trailLogArr;
}

//删除游记
-(void)deleteTrailLogFromDBWithUserID:(NSString*)userID
                                   ID:(NSString*)trailLogId
{
    sqlite3* db = [DataBaseManager openDataBase];
    NSString* sql = @"delete from TrailLog where userID = ? AND ID=?";
    sqlite3_stmt* stmt = nil;
    int flag = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, nil);
    if(flag == SQLITE_OK)
    {
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailLogId UTF8String], -1, nil);
        //执行
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            
        }
    }
    //释放
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
}



//路线收藏
-(void)saveTrailDetailWithUserID:(NSString*)userID
                TrailIntroduceId:(NSString*)trailId
                  TrailIntroduce:(NSData*)detail
                    TrailComment:(NSData*)comment
                 TrailOtherTrail:(NSData*)relative;
{
    sqlite3 *db=[DataBaseManager openDataBase];
    //
    NSString *sqlStr=@"INSERT INTO Trail  VALUES(?,?,?,?,?)";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailId UTF8String], -1, nil);
        sqlite3_bind_blob(stmt, 3, detail.bytes,(int)detail.length, nil);
        sqlite3_bind_blob(stmt, 4, comment.bytes, (int)comment.length, nil);
        sqlite3_bind_blob(stmt, 5, relative.bytes, (int)relative.length,nil);
    }
    

    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];

}

//返回ID判断  此收藏是否已存在
-(NSString*)querryTrailDetailWithUserID:(NSString*)userID
                                TrailId:(NSString*)trailId
{
    sqlite3 *db=[DataBaseManager openDataBase];
    
    NSString *sqlStr=@"SELECT ID FROM Trail WHERE userID=? AND ID=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailId UTF8String], -1, nil);
    }
    NSString *ID= nil;
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        
        ID=[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 0)];
    }
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    return ID;
   
}

//查询所有的路线data  //某个用户的所有收藏
-(NSArray*)querryTrailCollectFromDBWithUserID:(NSString*)userID;
{
    self.trailArr=[[NSMutableArray alloc]init];
    
    sqlite3 *db=[DataBaseManager openDataBase];
    NSString *sql=@"SELECT detail,comment,relative FROM Trail WHERE userID=?";
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    if (flag==SQLITE_OK) {
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        
        NSData *data1 = [NSData data];
        NSData *data2 = [NSData data];
        NSData *data3 = [NSData data];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            //新的 数据，需要新的  数组储存
            NSMutableArray *dataArr=[[NSMutableArray alloc]init];
            data1=[NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            [dataArr addObject:data1];
            data2=[NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            [dataArr addObject:data2];
            data3=[NSData dataWithBytes:sqlite3_column_blob(stmt, 2) length:sqlite3_column_bytes(stmt, 2)];
            [dataArr addObject:data3];
            
            [_trailArr addObject:dataArr];
        }
    }
    
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
    
    return _trailArr;
}

//删除指定收藏
-(void)deleteDetailFromDBWithUserID:(NSString*)userID
                            TrailId:(NSString*)trailId
{
    sqlite3* db = [DataBaseManager openDataBase];
    NSString* sql = @"delete from Trail where userID = ? AND ID=?";
    sqlite3_stmt* stmt = nil;
    int flag = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, nil);
    if(flag == SQLITE_OK)
    {
        //绑定
        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [trailId UTF8String], -1, nil);
        //执行
       if(sqlite3_step(stmt) == SQLITE_ROW)
       {
           
       }
    }
    //释放
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
}
@end
