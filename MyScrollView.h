//
//  MyScrollView.h
//  UIDay12
//
//  Created by coderss on 14-9-18.
//  Copyright (c) 2014年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BnsModel.h"

@protocol PushViewDelegate <NSObject>

- (void)pushNextViewWithModel:(BnsModel *)model;

@end

@interface MyScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_curImageView;
    UILabel *_labelTitle;
    
    UIPageControl *_pageCtrl;
    
    NSInteger _totalPages;
    int _curPages;
    CGRect _scrollFrame;
    
    NSArray *_imagesArray;
    NSMutableArray *_curImages;
}

@property(nonatomic,assign) id <PushViewDelegate> delegate;

-(int)validPageValue:(NSInteger)value;
-(id)initWithFrame:(CGRect)frame andPictures:(NSArray *)pictureArray;
-(NSArray *)getDisplayImagesWithCurpage:(int)page;
-(void)refreshScrollView;

@end
