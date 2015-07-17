//
//  MainViewCell.h
//  BnSBang
//
//  Created by coderss on 14-11-4.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong) MainModel *model;

@end
