//
//  BBSMoreViewCell.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-14.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BBSMoreViewCell.h"

@implementation BBSMoreViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BBSMoreModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    _userLabel.text=_model.author;
    _valueLabel.text=_model.number;
    
    _timeLabel.text=_model.dateline;
    
    NSString *str=[Tools replaceUnicodeStr:_model.message];
    _subjectLabel.text=str;
    
    CGSize newSize=[str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    _imgView.frame=CGRectMake(_imgView.frame.origin.x, _subjectLabel.frame.origin.y+newSize.height+5, _imgView.frame.size.width, _imgView.frame.size.height);
//    if (_model.imagelist.count!=0) {
//        [_imgView setImageWithURL:[NSURL URLWithString:_model.imagelist[0]] placeholderImage:[UIImage imageNamed:@"image"]];
//    }
}



@end
