//
//  ImageModel.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaseModel.h"

@interface ImageModel : BaseModel

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *cover_url;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *add_intro;

@property(nonatomic,copy)NSNumber *file_width;
@property(nonatomic,copy)NSNumber *file_height;
@property (nonatomic,assign)CGFloat cellHeight;

@end
