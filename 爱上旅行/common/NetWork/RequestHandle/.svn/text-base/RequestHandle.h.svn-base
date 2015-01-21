//
//  RequestHandle.h
//  DouBanProject
//
//  Created by 闪 on 14-12-8.
//  Copyright (c) 2014年 北京蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestHandle;
@protocol RequestHandleDelegate <NSObject>
//代理执行该方法 接收请求的数据data
@optional
-(void)requestHandle:(RequestHandle*)requestHandle
requestSucceedWithData:(NSData*)data;
-(void)requestHandle:(RequestHandle*)requestHandle
requestFailedWithError:(NSError*)error;


@end

@interface RequestHandle : NSObject <NSURLConnectionDataDelegate>
@property(nonatomic,assign)id<RequestHandleDelegate>delegate;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,retain)NSURLResponse *response;

//初始化方法
-(id)initWithURLString:(NSString*)urlString  paramString:(NSString*)paramString  method:(NSString*)method delegate:(id<RequestHandleDelegate>)delegate;

-(void)cancelConnection;
@end
