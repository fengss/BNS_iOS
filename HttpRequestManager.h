//
//  HttpRequestManager.h
//  BnSBang
//
//  Created by coderss on 14-10-31.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic,copy)NSURL *url;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,copy)void(^completecb)(NSData *);
@property(nonatomic,copy)void(^failedcb)();
@property(nonatomic,assign)NSURLRequestCachePolicy policy;

-(void)startRequest;

@end


@interface HttpRequestManager : NSObject

+(id)sharedManager;

-(void)GETUrl:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)policy completed:(void(^)(NSData *))completecb failed:(void(^)())failcb;
-(void)POSTUrl:(NSURL *)url WithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy completed:(void(^)(NSData *))completecb failed:(void(^)())failcb;

@end
