//
//  BnsViewCell.h
//  BnSBang
//
//  Created by coderss on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BnsModel.h"

@interface BnsViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic,strong)BnsModel *model;

@end
