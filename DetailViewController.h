//
//  DetailViewController.h
//  BnSBang
//
//  Created by coderss on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestManager.h"
#import "BnsModel.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_actView;
}

@property(nonatomic,strong)BnsModel *model;

- (void)loadWebView;

@end
