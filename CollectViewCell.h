//
//  CollectViewCell.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
#import "UIImageView+WebCache.h"

@interface CollectViewCell : UICollectionViewCell
{
    UIImageView *_imgv;
    UILabel *_titleLabel;
}

@property(nonatomic,strong)ImageModel *model;

@end
