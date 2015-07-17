//
//  MainViewController.h
//  BnSBang
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"
#import "MainViewCell.h"

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    CGSize _cSize;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

- (void)createBgImgView;
- (void)dataPrepare;
- (void)dataPrepareForResource:(NSString *)resource;

@end
