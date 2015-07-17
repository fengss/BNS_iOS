//
//  BBSDetailViewCell.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BBSDetailViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BBSDetailViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(BBSDetailModel *)model
{
    if (_model!=model) {
        _model=model;
    }
    _userLabel.text=_model.author;
    _valueLabel.text=[NSString stringWithFormat:@"回复 %@",_model.replies];
    _subjectLabel.text=_model.subject;
    _timeLabel.text=[self flattenHTML:_model.lastpost];
    
    NSString *str=_model.subject;
    CGSize newSize=[str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    _imgView.frame=CGRectMake(_imgView.frame.origin.x, _subjectLabel.frame.origin.y+newSize.height+5, _imgView.frame.size.width, _imgView.frame.size.height);
    if (_model.imagelist.count!=0) {
        [_imgView setImageWithURL:[NSURL URLWithString:_model.imagelist[0]] placeholderImage:[UIImage imageNamed:@"image"]];
    }
}



-(NSString *)flattenHTML:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    //NSLog(@"-----===%@",html);
    return html;
}

@end
