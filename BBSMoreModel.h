//
//  BBSMoreModel.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-14.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaseModel.h"

@interface BBSMoreModel : BaseModel

@property(nonatomic,copy)NSString *pid;
@property(nonatomic,copy)NSString *tid;
@property(nonatomic,copy)NSString *first;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *authorid;
@property(nonatomic,copy)NSString *subject;
@property(nonatomic,copy)NSString *dateline;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSArray *attachments;

@end
