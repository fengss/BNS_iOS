//
//  PhotoDetailController.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-11.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "PhotoViewController.h"
#import "ImageModel.h"

@interface PhotoDetailController : PhotoViewController

@property(nonatomic,strong)ImageModel *model;
@property(nonatomic,assign)NSInteger status;

@end
