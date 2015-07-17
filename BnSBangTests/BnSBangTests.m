//
//  BnSBangTests.m
//  BnSBangTests
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BnSBangTests : XCTestCase

@end

@implementation BnSBangTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testGetUrl
{
    NSURL *url=[NSURL URLWithString:@"http://appcms.duowan.com/?r=api/GetArticleDetail&url=http://bns.duowan.com/1408/271681394628.html"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];

    NSString *content=[dic[@"content"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",content);
}


- (void)testPostUrl
{
    NSURL *url=[NSURL URLWithString:@"http://appcms.duowan.com/?r=api/GetArticleListByTags"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"content-type"];
    NSString *str=@"lastId=278699833702&channel=bns&tags=PK%E8%A7%86%E9%A2%91";
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSError *error=nil;
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    else{
        NSString *getStr=[[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
        NSLog(@"str=>%@",getStr);
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
