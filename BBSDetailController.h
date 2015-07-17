//
//  BBSDetailController.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewController.h"
static NSInteger _BBSPage=1;

@interface BBSDetailController : BnsViewController <UIActionSheetDelegate>
{
    UIButton *_loadBtn;
    UIActivityIndicatorView *_indV;
}

@property(nonatomic,copy)NSString *fid;
@property(nonatomic,copy)NSString *bbsUrl;

@end
