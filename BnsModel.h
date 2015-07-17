//
//  BnsModel.h
//  BnSBang
//
//  Created by coderss on 14-10-31.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaseModel.h"

@interface BnsModel : BaseModel

@property(nonatomic,copy)NSString *channelId;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *tag;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pictureUrl;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *publishTime;
@property(nonatomic,copy)NSString *cover_url;

@end
