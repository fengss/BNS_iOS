//
//  MainViewCell.m
//  BnSBang
//
//  Created by coderss on 14-11-4.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MainViewCell.h"

@implementation MainViewCell
{
    NSDictionary *_colorDic;
}

- (void)awakeFromNib
{
    NSArray *keyArr=@[@"chuanshuo",@"zhizun",@"jingcui",@"qiqiao",@"fanpin"];
    NSArray *valueArr=@[[UIColor colorWithRed:0.9176 green:0.2863 blue:0.2118 alpha:1],
                        [UIColor colorWithRed:0.4246 green:0.2898 blue:0.5624 alpha:1],
                        [UIColor colorWithRed:0.1724 green:0.5291 blue:0.7397 alpha:1],
                        [UIColor colorWithRed:0.1812 green:0.6118 blue:0.3573 alpha:1],
                        [UIColor whiteColor],
                        ];
    _colorDic=[[NSDictionary alloc] initWithObjects:valueArr forKeys:keyArr];
}

-(void)setModel:(MainModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    _imgView.image=[UIImage imageNamed:_model.imgName];
    _nameLabel.textColor=_colorDic[_model.nameColor];
    _nameLabel.text=_model.name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
