//
//  RequestHandle.m
//  DouBanProject
//
//  Created by 闪 on 14-12-8.
//  Copyright (c) 2014年 北京蓝鸥科技有限公司. All rights reserved.
//

#import "RequestHandle.h"


@interface RequestHandle ()

@property(nonatomic,retain)NSMutableData *data;

@end

@implementation RequestHandle
//初始化方法
-(id)initWithURLString:(NSString*)urlString  paramString:(NSString*)paramString  method:(NSString*)method delegate:(id<RequestHandleDelegate>)delegate
{
    if (self=[super init]) {
        
        self.delegate=delegate;
        if ([method isEqualToString:@"GET"]) {
            [self requestDataWithURLString:urlString];
        }else if ([method isEqualToString:@"POST"]){
            [self requestDataWithURLString:urlString paramString:paramString];
        }
    }
    return self;
}
//请求数据  GET
-(void)requestDataWithURLString:(NSString*)urlString
{
    NSString *newStr=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:newStr];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

//请求数据  POST
-(void)requestDataWithURLString:(NSString*)urlString paramString:(NSString*)paramString
{
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSData *data=[paramString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

//实现代理方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{   
    self.data=[[NSMutableData alloc]init];
    self.response=response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //请求数据结束
    if ([_delegate respondsToSelector:@selector(requestHandle:requestSucceedWithData:)]) {
        [_delegate requestHandle:self requestSucceedWithData:self.data];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(requestHandle:requestFailedWithError:)]) {
        [_delegate requestHandle:self requestFailedWithError:error];
    }
}

-(void)cancelConnection
{
    [self.connection cancel];
}
@end
