//
//  BnsViewController.h
//  BnSBang
//
//  Created by coderss on 14-10-30.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
#import "RefreshView.h"
#import "HttpRequestManager.h"

@interface BnsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,PushViewDelegate>
{
    NSInteger _viewStatus;
    UITableView *_tableView;
    CGSize _screenSize;
    NSArray *_titleArr;
    UIView *_selectedView;
    RefreshView *_refreshView;
    MyScrollView *_scrollView;
    NSMutableArray *_scrollArray;
    NSMutableArray *_dataArray;
    BOOL _isRefreshing;
}

@property(nonatomic,copy)NSArray *bodyArr;
@property(nonatomic,copy)NSString *scrollUrl;

-(void)titleSettings;
-(void)prepareData;
-(void)uiconfig;
-(void)createRefreshView;
-(void)startLoading;
-(void)stopLoading;
-(void)createTopItems;
-(void)createTableView;
-(void)createTableViewWithFrame:(CGRect)frame;
-(void)topBtnAction:(UIButton *)sender;
-(void)getUrlWithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy;
-(void)refreshViewDidCallBack;

@end
