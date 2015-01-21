//
//  DataBaseManager.m
//  DoBan
//
//  Created by 闪 on 14-12-12.
//  Copyright (c) 2014年 北京蓝鸥科技有限公司. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

static sqlite3 *db=nil;

+(sqlite3*)openDataBase
{
    if (db) {
        return db;
    }
    
    //获取documents文件路径
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //拼接  DB.sqlite
    NSString *dbPath=[documentPath stringByAppendingPathComponent:@"ASLX.sqlite"];
    NSLog(@"%@",dbPath);
    //打开数据库
    int flag=sqlite3_open([dbPath UTF8String], &db);
    //判断
    if (flag==SQLITE_OK) {
        //sql语句创建表单
        //活动表单
        NSString *sqlStr=@"CREATE TABLE Activity (userId TEXT NOT NULL,activityId TEXT NOT NULL,detailData BLOB NOT NULL,activity BLOB NOT NULL)";
       
        NSString *sqlStr2=@"CREATE TABLE TrailLog (userID TEXT NOT NULL,ID TEXT NOT NULL,trailLog BLOB NOT NULL,trailDetail BLOB NOT NULL)";
        NSString *sqlStr3=@"CREATE TABLE Trail (userID TEXT NOT NULL,ID TEXT NOT NULL,detail BLOB NOT NULL,comment BLOB NOT NULL,relative BLOB NOT NULL)";
        
        sqlite3_exec(db, [sqlStr UTF8String], NULL, NULL, NULL);
        sqlite3_exec(db, [sqlStr2 UTF8String], NULL, NULL, NULL);
        sqlite3_exec(db, [sqlStr3 UTF8String], NULL, NULL, NULL);
        
    }
    return db;
}

+(void)closeDataBase
{
    int flag=sqlite3_close(db);
    if (flag==SQLITE_OK) {
        db=nil;
    }
}

@end
