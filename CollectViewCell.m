//
//  CollectViewCell.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "CollectViewCell.h"

@implementation CollectViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgv=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 150, self.contentView.bounds.size.height-10)];
        _imgv.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
        _imgv.contentMode=UIViewContentModeScaleAspectFill;
        _imgv.clipsToBounds=YES;
        [self.contentView addSubview:_imgv];
        
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, _imgv.frame.size.height-35, 150, 35)];
        _titleLabel.backgroundColor=[UIColor blackColor];
        _titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
        _titleLabel.numberOfLines=2;
        _titleLabel.textColor=[UIColor lightGrayColor];
        _titleLabel.alpha=0.6;
        [_imgv addSubview:_titleLabel];
    }
    return self;
}

-(void)setModel:(ImageModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    [_imgv setImageWithURL:[NSURL URLWithString:_model.cover_url]];
    
    if (!_model.file_width) {
        _titleLabel.text=_model.title;
    }
    else{
        _titleLabel.backgroundColor=[UIColor clearColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
