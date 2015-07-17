//
//  MyScrollView.m
//  UIDay12
//
//  Created by coderss on 14-9-18.
//  Copyright (c) 2014年 coderss. All rights reserved.
//

#import "MyScrollView.h"
#import "UIImageView+WebCache.h"

@implementation MyScrollView

-(id)initWithFrame:(CGRect)frame andPictures:(NSArray *)pictureArray
{
    self=[super initWithFrame:frame];
    if(self)
    {
        _scrollFrame=frame;
        _totalPages=[pictureArray count];
        _curPages=1;  //当前显示的是图片数组里的第一张图片
        _curImages=[[NSMutableArray alloc] init];
        _imagesArray=[[NSArray alloc] initWithArray:pictureArray];
        
        _scrollView=[[UIScrollView alloc] initWithFrame:frame];
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator=YES;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*3,_scrollView.frame.size.height);
        [self addSubview:_scrollView];
        [self refreshScrollView];
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateImage:) userInfo:nil repeats:YES];
        
        _labelTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView.bounds.size.height-20, _scrollView.bounds.size.width, 20)];
        //_labelTitle.backgroundColor=[UIColor blueColor];
        //_labelTitle.alpha=0.4;
        [self addSubview:_labelTitle];
        
        _pageCtrl=[[UIPageControl alloc] initWithFrame:CGRectMake(220, _scrollView.bounds.size.height-20, 100, 20)];
        _pageCtrl.numberOfPages=_totalPages;
        _pageCtrl.defersCurrentPageDisplay=YES;
        //_pageCtrl.pageIndicatorTintColor=[UIColor purpleColor];
        [self addSubview:_pageCtrl];
    }
    return self;
}

-(NSArray *)getDisplayImagesWithCurpage:(int)page
{
    int pre=[self validPageValue:page-1];
    int last=[self validPageValue:page+1];
    if([_curImages count]!=0)    [_curImages removeAllObjects];
    [_curImages addObject:[_imagesArray objectAtIndex:pre-1]];
    [_curImages addObject:[_imagesArray objectAtIndex:_curPages-1]];
    [_curImages addObject:[_imagesArray objectAtIndex:last-1]];
    return _curImages;
}

-(void)refreshScrollView
{
    NSArray *subViews=[_scrollView subviews];
    if([subViews count]!=0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPages];
    BnsModel *preImage=[_curImages objectAtIndex:0];
    BnsModel *curImage=[_curImages objectAtIndex:1];
    BnsModel *lastImage=[_curImages objectAtIndex:2];
    
    UIImageView *preView=[[UIImageView alloc] initWithFrame:_scrollFrame];
    preView.userInteractionEnabled=YES;
    [preView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    UIImageView *curView=[[UIImageView alloc] initWithFrame:_scrollFrame];
    curView.userInteractionEnabled=YES;
    [curView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    UIImageView *lastView=[[UIImageView alloc] initWithFrame:_scrollFrame];
    lastView.userInteractionEnabled=YES;
    [lastView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    [preView setImageWithURL:[NSURL URLWithString:preImage.pictureUrl]];
    [curView setImageWithURL:[NSURL URLWithString:curImage.pictureUrl]];
    [lastView setImageWithURL:[NSURL URLWithString:lastImage.pictureUrl]];
    [_scrollView addSubview:preView];
    [_scrollView addSubview:curView];
    [_scrollView addSubview:lastView];
    
    preView.frame=CGRectOffset(preView.frame, 0, 0);
    curView.frame=CGRectOffset(curView.frame, _scrollFrame.size.width, 0);
    lastView.frame=CGRectOffset(lastView.frame, _scrollFrame.size.width*2, 0);
    [_scrollView setContentOffset:CGPointMake(_scrollFrame.size.width, 0)];
    
    _pageCtrl.currentPage=_curPages-1;
}

-(void)tapAction:(UITapGestureRecognizer *)recognizer
{
    //NSLog(@"%@",[_curImages[1] pictureUrl]);
    BnsModel *model=_curImages[1];
    [self.delegate pushNextViewWithModel:model];
}
//-(void)tapActionCur
//{
//    
//}
//-(void)tapActionLast
//{
//    
//}



-(int)validPageValue:(NSInteger)value
{
    if(value==0)    value=_totalPages;    //value＝1为第一张，value=0为前面一张
    if(value==_totalPages+1)  value=1;
    return value;
}

- (void) scrollViewDidScroll:(UIScrollView *)crollView
{
    
    int x=crollView.contentOffset.x;
    //int y=crollView.contentOffset.y;
    
    if(x>=2*_scrollFrame.size.width) //往下翻一张
    {
        //NSLog(@"Yeah");
        _curPages=[self validPageValue:_curPages+1];
        [self refreshScrollView];
    }
    
    if(x<=0)
    {
        _curPages=[self validPageValue:_curPages-1];
        [self refreshScrollView];
    }
    
}

-(void)updateImage:(UIScrollView *)scrollView
{
    //NSLog(@"OK");
    [UIView animateWithDuration:0.5 animations:^{
        for (int i=0; i<3; i++) {
            UIImageView *subView=[_scrollView.subviews objectAtIndex:i];
            subView.frame=CGRectMake(subView.frame.origin.x-subView.frame.size.width, subView.frame.origin.y, subView.frame.size.width, subView.frame.size.height);
        }
        
    } completion:^(BOOL finished){
        _curPages=[self validPageValue:_curPages+1];
        [self refreshScrollView];
    }];
    
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
