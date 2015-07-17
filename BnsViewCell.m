//
//  BnsViewCell.m
//  BnSBang
//
//  Created by coderss on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BnsViewCell

- (void)awakeFromNib
{
    // Initialization code
    _titleImg.contentMode=UIViewContentModeScaleAspectFill;
    _titleImg.clipsToBounds=YES;
}

- (void)setModel:(BnsModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    if (_model.pictureUrl.length!=0) {
        [_titleImg setImageWithURL:[NSURL URLWithString:_model.pictureUrl] placeholderImage:[UIImage imageNamed:@"image"]];
    }
    else if(_model.cover_url.length!=0){
        [_titleImg setImageWithURL:[NSURL URLWithString:_model.cover_url] placeholderImage:[UIImage imageNamed:@"image"]];
    }
    else{
        _titleImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",arc4random()%10]];
    }
    
    _titleLabel.text=_model.title;
    _dateLabel.text=_model.publishTime;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
