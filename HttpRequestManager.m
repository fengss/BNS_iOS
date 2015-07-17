//
//  HttpRequestManager.m
//  BnSBang
//
//  Created by coderss on 14-10-31.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "HttpRequestManager.h"

@implementation HttpRequest
{
    NSMutableData *_data;
    //NSURLResponse *_response;
}

-(id)init
{
    if (self=[super init]) {
         _data=[[NSMutableData alloc] init];
    }
    return self;
}

-(void)startRequest
{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:_url cachePolicy:_policy timeoutInterval:20];
    [_data setData:nil];
    
    if (_body) {
        [request setHTTPMethod:@"POST"];
        NSString *srcBody=_body;
        NSData *data=[srcBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate:
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _failedcb();
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _completecb(_data);
}

@end



@implementation HttpRequestManager

+(id)sharedManager
{
    static HttpRequestManager *_manager=nil;
    if (!_manager) {
        _manager=[[HttpRequestManager alloc] init];
    }
    return _manager;
}

-(void)POSTUrl:(NSURL *)url WithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy completed:(void (^)(NSData *))completecb failed:(void (^)())failcb
{
    HttpRequest *httpReq=[[HttpRequest alloc] init];
    httpReq.url=url;
    httpReq.body=body;
    httpReq.policy=policy;
    httpReq.completecb=completecb;
    httpReq.failedcb=failcb;
    
    [httpReq startRequest];
}

-(void)GETUrl:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)policy completed:(void(^)(NSData *))completecb failed:(void(^)())failcb
{
    [self POSTUrl:url WithBody:nil cachePolicy:policy completed:completecb failed:failcb];
}

@end
