//
//  BBSDetailModel.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaseModel.h"

@interface BBSDetailModel : BaseModel

@property(nonatomic,copy)NSString *tid;
@property(nonatomic,copy)NSString *subject;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *authorid;
@property(nonatomic,copy)NSString *dateline;
@property(nonatomic,copy)NSString *views;
@property(nonatomic,copy)NSString *replies;
@property(nonatomic,copy)NSString *lastpost;
@property(nonatomic,copy)NSString *lastposter;
@property(nonatomic,copy)NSArray *imagelist;

@end
