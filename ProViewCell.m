//
//  ProViewCell.m
//  BnSBang
//
//  Created by coderss on 14-11-6.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "ProViewCell.h"

@implementation ProViewCell

- (void)awakeFromNib
{
    // Initialization code
    _zyView.layer.cornerRadius=30;
    _zyView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ProModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    _titleLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:_model.bglabel]];
    _titleLabel.text=_model.name;
    _zzView.image=[UIImage imageNamed:_model.zZimg];
    _zyView.image=[UIImage imageNamed:_model.zYimg];
}


- (IBAction)onClick:(UIButton *)sender
{
    NSInteger bodyType=sender.tag-600;
    NSArray *typeArr=@[@"单刷",@"连招",@"比武"];
    [self.delegate pushNextViewControllerWithUrl:_model.postBody[bodyType] andName:_model.name andType:typeArr[bodyType]];
}

@end
