//
//  BaguaDetailController.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface BaguaDetailController : UIViewController
{
    UIScrollView *_scrollView;
    UIImageView *_propertyView;
}

@property(nonatomic,strong)MainModel *model;

- (void)createUI;

@end
